defmodule AdventureTime.GridSquareTest do
  use ExUnit.Case, async: true

  alias AdventureTime.GridSquare
  alias AdventureTime.Player

  doctest GridSquare

  describe "find_by_grid_ref/2" do
    test "it returns the grid_square with the passed in grid_ref" do
      grid = %{
        0 => %{
          0 => %GridSquare{grid_ref: {0, 0}, walkable: false},
          1 => %GridSquare{grid_ref: {0, 1}, walkable: false}
        },
        1 => %{
          0 => %GridSquare{grid_ref: {1, 0}, walkable: false},
          1 => %GridSquare{grid_ref: {1, 1}, walkable: true}
        }
      }

      assert GridSquare.find_by_grid_ref(grid, {1, 1}) == %GridSquare{
               grid_ref: {1, 1},
               walkable: true
             }
    end
  end
end
