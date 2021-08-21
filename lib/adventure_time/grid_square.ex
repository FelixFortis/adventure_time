defmodule AdventureTime.GridSquare do
  @enforce_keys [:grid_ref, :walkable]
  defstruct [:grid_ref, :walkable]

  def find_by_grid_ref(arena, grid_ref) do
    arena
    |> List.flatten()
    |> Enum.find(fn grid_square -> grid_square.grid_ref == grid_ref end)
  end
end
