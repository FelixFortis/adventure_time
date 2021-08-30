defmodule AdventureTime.GameTile do
  @moduledoc """
  A struct which represents a single tile on the game's arena - contains the location and status of the tile
  Module contains functions around dealing with tiles on an individual basis
  """

  alias AdventureTime.{Arena, HeroServer}

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

  def heroes_on_tile(tile_ref) do
    heroes = HeroServer.all_heroes()

    heroes
    |> Enum.filter(fn hero ->
      hero.tile_ref == tile_ref
    end)
  end

  def hero_on_tile?(tile_ref, hero_name) do
    case check_tile_for_hero(tile_ref, hero_name) do
      nil -> false
      _ -> true
    end
  end

  def heroes_on_tile?(tile_ref) do
    heroes_on_tile = heroes_on_tile(tile_ref)

    case length(heroes_on_tile) do
      0 -> false
      _ -> true
    end
  end

  def hero_count(tile_ref) do
    length(heroes_on_tile(tile_ref))
  end

  def anyone_alive_on_tile?(tile_ref) do
    length(alive_heroes_on_tile(tile_ref)) > 0
  end

  def alive_enemies_on_tile?(tile_ref, hero_name) do
    length(alive_enemies_on_tile(tile_ref, hero_name)) > 0
  end

  defp alive_enemies_on_tile(tile_ref, hero_name) do
    heroes = alive_heroes_on_tile(tile_ref)

    heroes
    |> Enum.filter(fn hero ->
      hero.name != hero_name
    end)
  end

  defp alive_heroes_on_tile(tile_ref) do
    heroes_on_tile = heroes_on_tile(tile_ref)

    heroes_on_tile
    |> Enum.filter(fn hero ->
      hero.alive == true
    end)
  end

  defp check_tile_for_hero(tile_ref, hero_name) do
    heroes = HeroServer.all_heroes()

    heroes
    |> Enum.filter(fn hero ->
      hero.tile_ref == tile_ref
    end)
    |> Enum.find(fn hero ->
      hero.name == hero_name
    end)
  end
end
