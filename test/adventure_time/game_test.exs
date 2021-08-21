defmodule AdventureTime.GameTest do
  use ExUnit.Case, async: true

  alias AdventureTime.{Game, Player, GridSquare}

  doctest Game

  setup do
    # ensure the random placement is predictable for these tests
    :rand.seed(:exsplus, {100, 101, 102})
    game = Game.new()

    [
      game: game,
      game_with_player: game |> Game.spawn_player("test")
    ]
  end

  describe "new/0" do
    test "it creates a new game with no players on a 10x10 arena" do
      game = Game.new()
      assert game.players == %{}
      assert length(Map.keys(game.arena)) == 10
      assert length(Map.keys(game.arena[0])) == 10
    end
  end

  describe "spawn_player/1" do
    test "it adds a new player to the game on a walkable grid_square", context do
      assert context.game_with_player.players == %{
               test: %Player{
                 grid_ref: {2, 3},
                 name: "test",
                 tag: :test,
                 alive: true,
                 respawnable: false
               }
             }
    end

    test "the new player can be found on the grid_square", context do
      player = context.game_with_player.players[:test]

      player_grid_square =
        GridSquare.find_by_grid_ref(context.game_with_player.arena, player.grid_ref)

      assert player_grid_square.players == %{player.tag => player}
    end
  end
end
