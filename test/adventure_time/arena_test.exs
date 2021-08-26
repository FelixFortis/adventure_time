defmodule AdventureTime.ArenaTest do
  use ExUnit.Case, async: true

  alias AdventureTime.{Arena, GameTile, Game, Player}

  doctest Arena

  describe "walkable_grid_refs/1" do
    test "it returns a list of walkable grid references" do
      arena = Arena.arena()
      grid_refs = Arena.walkable_grid_refs(arena)

      grid_refs
      |> Enum.each(fn grid_ref ->
        game_tile = GameTile.find_by_grid_ref(arena, grid_ref)

        assert game_tile.walkable == true
      end)
    end
  end

  describe "game_tiles_as_flattened_list/1" do
    test "it returns all game_tiles as a list of maps" do
      arena = %{
        0 => %{
          0 => %GameTile{grid_ref: {0, 0}, walkable: false, players: %{}},
          1 => %GameTile{grid_ref: {0, 1}, walkable: false, players: %{}}
        },
        1 => %{
          0 => %GameTile{grid_ref: {1, 0}, walkable: false, players: %{}},
          1 => %GameTile{grid_ref: {1, 1}, walkable: true, players: %{}}
        }
      }

      assert Arena.game_tiles_as_flattened_list(arena) == [
               %GameTile{grid_ref: {0, 0}, walkable: false, players: %{}},
               %GameTile{grid_ref: {0, 1}, walkable: false, players: %{}},
               %GameTile{grid_ref: {1, 0}, walkable: false, players: %{}},
               %GameTile{grid_ref: {1, 1}, walkable: true, players: %{}}
             ]
    end
  end

  describe "player_grid_ref/2" do
    test "it returns the grid_ref of the passed in player" do
      :rand.seed(:exsplus, {100, 101, 102})

      # the seed that we assigned the :rand function above means we know that the player will be assigned to grid {2, 3}
      player = Player.new("test")
      game = Game.new() |> Game.spawn_player(player)

      assert Arena.player_grid_ref(game.arena, player) == {2, 3}
    end
  end
end
