defmodule AdventureTime.Hero do
  @moduledoc """
  A hero struct and the main component of the game - contains the location and status of the hero
  Module contains functions around hero actions like movement.
  """

  alias AdventureTime.{Hero, GameTile, Arena, NameGenerator}

  @enforce_keys [:name]
  defstruct [:name, :tag, :tile_ref, :alive]

  def new(name \\ "", tile_ref) do
    hero_name = set_hero_name(name)
    tag = parse_player_tag(name)

    %Hero{
      name: hero_name,
      tag: tag,
      tile_ref: tile_ref,
      alive: true
    }
  end

  def move_to(hero, new_tile_ref) do
    if GameTile.walkable?(new_tile_ref) && Arena.adjacent?(hero.tile_ref, new_tile_ref) do
      hero
      |> insert_at(new_tile_ref)
    else
      hero
    end
  end

  def die(hero) do
    hero
    |> mark_as_dead()
  end

  def respawn(hero) do
    hero
    |> mark_as_alive()
    |> insert_at(Arena.random_walkable_tile_ref_except(hero.tile_ref))
  end

  def parse_player_tag(player_name) do
    player_name
    |> String.downcase()
    |> String.replace(" ", "_")
    |> String.to_atom()
  end

  defp mark_as_dead(hero) do
    hero
    |> Map.put(:alive, false)
  end

  defp mark_as_alive(hero) do
    hero
    |> Map.put(:alive, true)
  end

  defp insert_at(hero, new_tile_ref) do
    hero
    |> Map.put(:tile_ref, new_tile_ref)
  end

  defp set_hero_name(name) do
    case name do
      "" ->
        NameGenerator.generate()

      chosen_name ->
        chosen_name
    end
  end
end
