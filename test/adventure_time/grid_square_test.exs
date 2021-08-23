defmodule AdventureTime.GridSquareTest do
  use ExUnit.Case, async: true

  alias AdventureTime.{GridSquare, Player}

  doctest GridSquare

  setup do
    arena = %{
      0 => %{
        0 => %GridSquare{grid_ref: {0, 0}, walkable: false},
        1 => %GridSquare{grid_ref: {0, 1}, walkable: false}
      },
      1 => %{
        0 => %GridSquare{grid_ref: {1, 0}, walkable: false},
        1 => %GridSquare{grid_ref: {1, 1}, walkable: true}
      }
    }

    [
      arena: arena
    ]
  end

  describe "find_by_grid_ref/2" do
    test "it returns the grid_square with the passed in grid_ref", context do
      assert GridSquare.find_by_grid_ref(context.arena, {1, 1}) == %GridSquare{
               grid_ref: {1, 1},
               walkable: true
             }
    end
  end

  describe "players/2" do
  end

  describe "walkable?/2" do
    test "it returns true for a walkable grid square", context do
      assert GridSquare.walkable?(context.arena, {1, 1}) == true
    end

    test "it returns false for an unwalkable grid square", context do
      assert GridSquare.walkable?(context.arena, {0, 1}) == false
    end
  end
end
