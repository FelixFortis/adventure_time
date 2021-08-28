defmodule AdventureTime.GameTile do
  @moduledoc """
  A struct which represents a single tile on the game's arena - contains the location and status of the tile
  Module contains functions around dealing with tiles on an individual basis
  """

  alias AdventureTime.Arena

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
end
