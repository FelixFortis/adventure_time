defmodule AdventureTime.GameTile do
  @moduledoc """
  A struct which represents a single tile on the game's arena - contains the location and status of the tile
  Module contains functions around dealing with tiles on an individual basis
  """

  alias AdventureTime.{Arena, Hero}

  @enforce_keys [:tile_ref, :walkable]
  defstruct [:tile_ref, :walkable]

  def find_by_tile_ref(tile_ref) do
    Arena.game_tiles_as_flattened_list()
    |> Enum.find(fn game_tile -> game_tile.tile_ref == tile_ref end)
  end

  def walkable?(tile_ref) do
    game_tile = find_by_tile_ref(tile_ref)

    game_tile.walkable == true
  end

  def hero_on_tile?(game_tile_ref, hero_name) do
    case check_tile_for_hero(game_tile_ref, hero_name) do
      nil -> false
      _ -> true
    end
  end

  def heroes_on_tile?(game_tile_ref) do
    heroes_on_tile = check_tile_for_heroes(game_tile_ref)

    case length(heroes_on_tile) do
      0 -> false
      _ -> true
    end
  end

  def hero_count(game_tile_ref) do
    length(check_tile_for_heroes(game_tile_ref))
  end

  defp check_tile_for_hero(game_tile_ref, hero_name) do
    heroes = Hero.all_heroes()

    heroes
    |> Enum.filter(fn hero ->
      hero.tile_ref == game_tile_ref
    end)
    |> Enum.find(fn hero ->
      hero.name == hero_name
    end)
  end

  defp check_tile_for_heroes(game_tile_ref) do
    heroes = Hero.all_heroes()

    heroes
    |> Enum.filter(fn hero ->
      hero.tile_ref == game_tile_ref
    end)
  end
end
