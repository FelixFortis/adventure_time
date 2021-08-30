defmodule AdventureTime.ArenaTest do
  use ExUnit.Case, async: true

  alias AdventureTime.{Arena, GameTile}

  doctest Arena

  setup do
    [
      arena_as_map: Arena.arena_as_map(),
      arena_as_list: Arena.arena_as_list()
    ]
  end

  describe "arena_as_map/0" do
    test "it returns a 10x10 arena as a nested map of maps", context do
      assert length(Map.keys(context.arena_as_map)) == 10
      assert length(Map.keys(context.arena_as_map[0])) == 10
    end
  end

  describe "arena_as_list/0" do
    test "it returns a 10x10 arena as a nested list of lists", context do
      assert length(context.arena_as_list) == 10
      assert length(hd(context.arena_as_list)) == 10
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

  describe "walkable_tile_refs_except/1" do
    test "it returns a list of walkable grid references, not including the passed in tile_ref" do
      current_tile_ref = {2, 3}
      tile_refs = Arena.walkable_tile_refs_except(current_tile_ref)

      tile_refs
      |> Enum.each(fn tile_ref ->
        game_tile = GameTile.find_by_tile_ref(tile_ref)

        assert game_tile.walkable == true
        assert game_tile.tile_ref != current_tile_ref
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

  describe "random_walkable_tile_ref_except/1" do
    test "it returns the tile_ref of a random walkable game tile, excluding the passed in tile_ref" do
      # for this test we need to ensure the randomness is predictable
      # using this seed would normally force the tile_ref to be {2, 3}
      :rand.seed(:exsplus, {100, 101, 102})

      assert Arena.random_walkable_tile_ref_except({2, 3}) == {2, 4}
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
