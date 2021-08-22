defmodule AdventureTime.GridSquare do
  alias AdventureTime.Arena

  @enforce_keys [:grid_ref, :walkable]
  defstruct [:grid_ref, :walkable, players: %{}]

  def find_by_grid_ref(arena, grid_ref) do
    arena
    |> Arena.grid_squares_as_flattened_list()
    |> Enum.find(fn grid_square -> grid_square.grid_ref == grid_ref end)
  end

  def players(arena, grid_ref) do
    grid_square = find_by_grid_ref(arena, grid_ref)
    grid_square.players
  end
end
