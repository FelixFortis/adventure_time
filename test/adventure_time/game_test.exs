defmodule AdventureTime.GameTest do
  use ExUnit.Case, async: true

  alias AdventureTime.Game
  alias AdventureTime.Player

  doctest Game

  describe "new/0" do
    test "it creates a new game with no players" do
      game = Game.new()
      assert game.players == []
      assert length(game.arena) == 10
    end
  end

  describe "add_player/1" do
    test "it adds a player with to the game with the passed in name" do
      empty_game = Game.new()

      game_with_player =
        empty_game
        |> Game.add_player("test")

      assert game_with_player.players == [%Player{name: "test", grid_ref: {0, 0}}]
    end
  end
end
