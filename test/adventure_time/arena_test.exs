defmodule AdventureTime.ArenaTest do
  use ExUnit.Case, async: true

  alias AdventureTime.{Arena, GameTile}

  doctest Arena

  setup do
    [
      arena: Arena.arena()
    ]
  end

  describe "arena/0" do
    test "it creates a new game on a 10x10 arena", context do
      assert length(Map.keys(context.arena)) == 10
      assert length(Map.keys(context.arena[0])) == 10
    end
  end

  describe "walkable_tile_refs/1" do
    test "it returns a list of walkable grid references" do
      tile_refs = Arena.walkable_tile_refs()

      tile_refs
      |> Enum.each(fn tile_ref ->
        game_tile = GameTile.find_by_tile_ref(tile_ref)

        assert game_tile.walkable == true
      end)
    end
  end

  describe "random_walkable_tile_ref/0" do
    test "it returns the tile_ref of a random walkable game tile" do
      # for this test we need to ensure the randomness is predictable
      :rand.seed(:exsplus, {100, 101, 102})

      assert Arena.random_walkable_tile_ref() == {2, 3}
    end
  end

  describe "game_tiles_as_flattened_list/0" do
    test "it returns all game_tiles as a list of maps" do
      assert length(Arena.game_tiles_as_flattened_list()) == 100
    end
  end

  describe "adjacent?/2" do
    test "it returns true for an adjacent game tile" do
      assert Arena.adjacent?({5, 5}, {5, 6}) == true
    end

    test "it returns false for a non-adjacent game tile" do
      assert Arena.adjacent?({5, 5}, {5, 7}) == false
    end
  end

  describe "interactable_tile_refs/2" do
    test "it returns a list of tile_refs - the given tile_ref and all adjacent walkable tile_refs" do
      assert Arena.interactable_tile_refs({5, 2}) == [
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
