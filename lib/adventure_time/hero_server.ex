defmodule AdventureTime.HeroServer do
  alias AdventureTime.{Hero, Arena}

  @moduledoc """
  A hero server process that holds a `Hero` struct as its state.
  """

  use GenServer

  require Logger

  @timeout :timer.minutes(45)

  # Public API

  @doc """
  Spawns a new hero server process registered under the given `hero_name`.
  The hero spawn location will be random.
  """
  def start_link(hero_name) do
    GenServer.start_link(
      __MODULE__,
      hero_name,
      name: via_hero_registry(hero_name)
    )
  end

  @doc """
  Spawns a new hero server process registered under the given `hero_name`.
  The hero spawn location will be predictably random based on the passed in `seed`.
  """
  def start_link(hero_name, seed) do
    GenServer.start_link(
      __MODULE__,
      {hero_name, seed},
      name: via_hero_registry(hero_name)
    )
  end

  def all_heroes_as_list do
    :ets.tab2list(:heroes_table)
    |> Enum.map(fn {_hero_name, hero} ->
      hero
    end)
  end

  def all_heroes_as_map do
    :ets.tab2list(:heroes_table)
    |> Map.new(fn
      {key, value} -> {Hero.parse_player_tag(key), value}
    end)
  end

  def get_hero(hero_name) do
    GenServer.call(via_hero_registry(hero_name), :get_hero)
  end

  def tile_ref(hero_name) do
    GenServer.call(via_hero_registry(hero_name), :tile_ref)
  end

  def alive?(hero_name) do
    GenServer.call(via_hero_registry(hero_name), :alive?)
  end

  def move_to(hero_name, new_tile_ref) do
    GenServer.call(via_hero_registry(hero_name), {:move_to, new_tile_ref})
  end

  def die(hero_name) do
    GenServer.call(via_hero_registry(hero_name), :die)
  end

  def respawn(hero_name) do
    GenServer.call(via_hero_registry(hero_name), :respawn)
  end

  def attack(hero_name) do
    GenServer.call(via_hero_registry(hero_name), :attack)
  end

  @doc """
  Returns a tuple which registers and looks up a hero server process by `hero_name`.
  """
  def via_hero_registry(hero_name) do
    {:via, Registry, {AdventureTime.HeroRegistry, hero_name}}
  end

  @doc """
  Returns the `pid` of the hero server process registered under the
  passed in `hero_name`, or `nil` if no process is registered.
  """
  def hero_pid(hero_name) do
    hero_name
    |> via_hero_registry()
    |> GenServer.whereis()
  end

  # Server functions

  # we can optionally pass a seed when we need to ensure the randomness is predictable, for example during testing
  def init({hero_name, seed}) do
    :rand.seed(:exsplus, seed)

    init(hero_name)
  end

  def init(hero_name) do
    hero =
      case :ets.lookup(:heroes_table, hero_name) do
        [] ->
          hero = Hero.new(hero_name, Arena.random_walkable_tile_ref())

          :ets.insert(:heroes_table, {hero_name, hero})
          hero

        [{^hero_name, hero}] ->
          hero
      end

    # Logger.info("'#{hero_name}' hero server process spawned.")

    {:ok, hero, @timeout}
  end

  def handle_call(:get_hero, _from, hero) do
    {:reply, hero, hero, @timeout}
  end

  def handle_call(:tile_ref, _from, hero) do
    {:reply, hero.tile_ref, hero, @timeout}
  end

  def handle_call(:alive?, _from, hero) do
    {:reply, hero.alive, hero, @timeout}
  end

  def handle_call({:move_to, new_tile_ref}, _from, hero) do
    case hero.alive do
      false ->
        {:reply, hero, hero, @timeout}

      true ->
        moved_hero = Hero.move_to(hero, new_tile_ref)

        :ets.insert(:heroes_table, {hero.name, moved_hero})

        {:reply, moved_hero, moved_hero, @timeout}
    end
  end

  def handle_call(:die, _from, hero) do
    dead_hero = Hero.die(hero)

    :ets.insert(:heroes_table, {hero.name, dead_hero})

    {:reply, dead_hero, dead_hero, @timeout}
  end

  def handle_call(:respawn, _from, hero) do
    respawned_hero = Hero.respawn(hero)

    :ets.insert(:heroes_table, {hero.name, respawned_hero})

    {:reply, respawned_hero, respawned_hero, @timeout}
  end

  def handle_call(:attack, _from, hero) do
    case hero.alive do
      false ->
        {:reply, hero, hero, @timeout}

      true ->
        nearby_heroes = Arena.adjacent_heroes(hero.tile_ref)

        nearby_heroes
        |> Enum.filter(fn nearby_hero ->
          nearby_hero.name != hero.name
        end)
        |> kill_nearby_enemy_heroes()

        {:reply, hero, hero, @timeout}
    end
  end

  def handle_info(:timeout, hero) do
    {:stop, {:shutdown, :timeout}, hero}
  end

  def terminate({:shutdown, :timeout}, hero) do
    :ets.delete(:heroes_table, hero.name)
    :ok
  end

  def terminate(_reason, _hero) do
    :ok
  end

  defp kill_nearby_enemy_heroes(enemy_heroes) do
    enemy_heroes
    |> Enum.each(fn enemy_hero ->
      GenServer.call(via_hero_registry(enemy_hero.name), :die)
    end)
  end
end
