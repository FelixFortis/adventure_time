defmodule AdventureTime.Hero do
  @moduledoc """
  A hero struct and the main component of the game - contains the location and status of the hero
  Module contains functions around hero actions like movement.
  """

  alias AdventureTime.{Hero, GameTile, Arena}

  @enforce_keys [:name]
  defstruct [:name, :tile_ref, :alive]

  @adjectives Application.get_env(:adventure_time, :adjectives)
  @nouns Application.get_env(:adventure_time, :nouns)

  def new(name \\ "", tile_ref) do
    hero_name = set_hero_name(name)

    %Hero{
      name: hero_name,
      tile_ref: tile_ref,
      alive: true
    }
  end

  def all_heroes do
    :ets.tab2list(:heroes_table)
    |> Enum.map(fn {_hero_name, hero} ->
      hero
    end)
  end

  def die_and_respawn(hero) do
    hero
    |> mark_as_dead()
    |> respawn_cooldown()
    |> mark_as_alive()
    |> respawn()
  end

  def move_to(hero, new_tile_ref) do
    if GameTile.walkable?(new_tile_ref) && Arena.adjacent?(hero.tile_ref, new_tile_ref) do
      hero
      |> insert_at(new_tile_ref)
    else
      hero
    end
  end

  def random_name(range \\ 9999, delimiter \\ "_") do
    :rand.seed(:exsplus)
    token = if range > 0, do: random(range)

    [@adjectives, @nouns]
    |> Enum.map(&sample/1)
    |> Enum.concat(List.wrap(token))
    |> Enum.join(delimiter)
  end

  defp mark_as_dead(hero) do
    hero
    |> Map.put(:alive, false)
  end

  defp mark_as_alive(hero) do
    hero
    |> Map.put(:alive, true)
  end

  defp respawn_cooldown(hero) do
    :timer.seconds(5)
    hero
  end

  defp respawn(hero) do
    hero
    |> insert_at(Arena.random_walkable_tile_ref())
  end

  defp insert_at(hero, new_tile_ref) do
    hero
    |> Map.put(:tile_ref, new_tile_ref)
  end

  defp random(range) when range > 0, do: :rand.uniform(range)

  defp sample(array), do: Enum.random(array)

  defp set_hero_name(name) do
    case name do
      "" ->
        random_name()

      chosen_name ->
        chosen_name
    end
  end
end
