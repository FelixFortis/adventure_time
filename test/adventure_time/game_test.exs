defmodule AdventureTime.GameTest do
  use ExUnit.Case, async: true

  alias AdventureTime.Game
  alias AdventureTime.Player

  doctest Game

  describe "new/0" do
    test "it creates a new game with no players on a 10x10 arena" do
      game = Game.new()
      assert game.players == %{}
      assert length(Map.keys(game.arena)) == 10
      assert length(Map.keys(game.arena[0])) == 10
    end
  end

  describe "spawn_player/1" do
    test "it adds a player to the game with the passed in name on a random walkable tile" do
      # ensure the random placement is predictable for this test
      :rand.seed(:exsplus, {100, 101, 102})

      empty_game = Game.new()

      game_with_player =
        empty_game
        |> Game.spawn_player("test")

      assert game_with_player.players == %{
               test: %Player{
                 grid_ref: {2, 3},
                 name: "test",
                 tag: :test,
                 alive: true,
                 respawnable: false
               }
             }
    end
  end
end
