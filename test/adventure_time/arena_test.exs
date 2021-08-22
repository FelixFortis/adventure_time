defmodule AdventureTime.ArenaTest do
  use ExUnit.Case, async: true

  alias AdventureTime.Arena
  alias AdventureTime.GridSquare

  doctest Arena

  describe "walkable_grid_refs/1" do
    test "it returns a list of walkable grid references" do
      arena = Arena.arena()
      grid_refs = Arena.walkable_grid_refs(arena)

      grid_refs
      |> Enum.each(fn grid_ref ->
        grid_square = GridSquare.find_by_grid_ref(arena, grid_ref)

        assert grid_square.walkable == true
      end)
    end
  end

  describe "grid_squares_as_flattened_list/1" do
    test "it returns all grid_squares as a list of maps" do
      arena = %{
        0 => %{
          0 => %GridSquare{grid_ref: {0, 0}, walkable: false, players: %{}},
          1 => %GridSquare{grid_ref: {0, 1}, walkable: false, players: %{}}
        },
        1 => %{
          0 => %GridSquare{grid_ref: {1, 0}, walkable: false, players: %{}},
          1 => %GridSquare{grid_ref: {1, 1}, walkable: true, players: %{}}
        }
      }

      assert Arena.grid_squares_as_flattened_list(arena) == [
               %GridSquare{grid_ref: {0, 0}, walkable: false, players: %{}},
               %GridSquare{grid_ref: {0, 1}, walkable: false, players: %{}},
               %GridSquare{grid_ref: {1, 0}, walkable: false, players: %{}},
               %GridSquare{grid_ref: {1, 1}, walkable: true, players: %{}}
             ]
    end
  end
end
