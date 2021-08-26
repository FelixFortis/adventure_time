defmodule AdventureTime.GameTile do
  alias AdventureTime.Arena

  @enforce_keys [:grid_ref, :walkable]
  defstruct [:grid_ref, :walkable, players: %{}]

  def find_by_grid_ref(arena, grid_ref) do
    arena
    |> Arena.game_tiles_as_flattened_list()
    |> Enum.find(fn game_tile -> game_tile.grid_ref == grid_ref end)
  end

  def players(arena, grid_ref) do
    game_tile = find_by_grid_ref(arena, grid_ref)
    game_tile.players
  end

  def walkable?(arena, grid_ref) do
    game_tile = find_by_grid_ref(arena, grid_ref)

    game_tile.walkable == true
  end

  def interactable_grid_refs(arena, current_grid_ref) do
    walkable_grid_refs = Arena.walkable_grid_refs(arena)
    {y_axis, x_axis} = current_grid_ref

    potential_grid_refs = [
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

    Enum.filter(potential_grid_refs, fn grid_ref ->
      Enum.member?(walkable_grid_refs, grid_ref)
    end)
  end
end
