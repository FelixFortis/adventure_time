defmodule AdventureTime.GameTile do
  alias AdventureTime.Arena

  @enforce_keys [:tile_ref, :walkable]
  defstruct [:tile_ref, :walkable]

  def find_by_tile_ref(tile_ref) do
    Arena.game_tiles_as_flattened_list()
    |> Enum.find(fn game_tile -> game_tile.tile_ref == tile_ref end)
  end

  def players(_tile_ref) do
    # get a list of attackable players
  end

  def walkable?(tile_ref) do
    game_tile = find_by_tile_ref(tile_ref)

    game_tile.walkable == true
  end

  def adjacent?(current_tile_ref, new_tile_ref) do
    new_tile_ref in interactable_tile_refs(current_tile_ref)
  end

  def interactable_tile_refs(current_tile_ref) do
    walkable_tile_refs = Arena.walkable_tile_refs()
    {y_axis, x_axis} = current_tile_ref

    potential_tile_refs = [
      {y_axis - 1, x_axis - 1},
      {y_axis - 1, x_axis},
      {y_axis - 1, x_axis + 1},
      {y_axis, x_axis - 1},
      {y_axis, x_axis},
      {y_axis, x_axis + 1},
      {y_axis + 1, x_axis - 1},
      {y_axis + 1, x_axis},
      {y_axis + 1, x_axis + 1}
    ]

    Enum.filter(potential_tile_refs, fn tile_ref ->
      Enum.member?(walkable_tile_refs, tile_ref)
    end)
  end
end
