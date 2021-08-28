defmodule AdventureTime.HeroServer do
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

  def tile_ref(hero_name) do
    GenServer.call(via_hero_registry(hero_name), :tile_ref)
  end

  def alive?(hero_name) do
    GenServer.call(via_hero_registry(hero_name), :alive?)
  end

  def move_to(hero_name, new_tile_ref) do
    GenServer.call(via_hero_registry(hero_name), {:move_to, new_tile_ref})
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
          hero = AdventureTime.Hero.new(hero_name, AdventureTime.Arena.random_walkable_tile_ref())

          :ets.insert(:heroes_table, {hero_name, hero})
          hero

        [{^hero_name, hero}] ->
          hero
      end

    Logger.info("'#{hero_name}' hero server process spawned.")

    {:ok, hero, @timeout}
  end

  def handle_call(:tile_ref, _from, hero) do
    {:reply, hero.tile_ref, hero, @timeout}
  end

  def handle_call(:alive?, _from, hero) do
    {:reply, hero.alive, hero, @timeout}
  end

  def handle_call({:move_to, new_tile_ref}, _from, hero) do
    {:reply, AdventureTime.Hero.move_to(hero, new_tile_ref), hero, @timeout}
  end
end