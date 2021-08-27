defmodule AdventureTime.GameTileTest do
  use ExUnit.Case, async: true

  alias AdventureTime.{GameTile}

  doctest GameTile

  describe "find_by_tile_ref/2" do
    test "it returns the game_tile with the passed in tile_ref" do
      assert GameTile.find_by_tile_ref({1, 0}) == %GameTile{
               tile_ref: {1, 0},
               walkable: false
             }
    end
  end

  describe "walkable?/1" do
    test "it returns true for a walkable game tile" do
      assert GameTile.walkable?({1, 1}) == true
    end

    test "it returns false for an unwalkable game tile" do
      assert GameTile.walkable?({0, 1}) == false
    end
  end
end
