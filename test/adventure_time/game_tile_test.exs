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
    test "it returns true for a walkable grid square" do
      assert GameTile.walkable?({1, 1}) == true
    end

    test "it returns false for an unwalkable grid square" do
      assert GameTile.walkable?({0, 1}) == false
    end
  end

  describe "interactable_tile_refs/2" do
    test "it returns a list of tile_refs - the given tile_ref and all adjacent walkable tile_refs" do
      assert GameTile.interactable_tile_refs({5, 2}) == [
               {4, 1},
               {4, 2},
               {4, 3},
               {5, 1},
               {5, 2},
               {5, 3},
               {6, 1}
             ]
    end
  end
end
