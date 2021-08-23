defmodule AdventureTime.GameTest do
  use ExUnit.Case, async: true

  alias AdventureTime.{Game, Player, GridSquare}

  doctest Game

  setup do
    # ensure the random placement is predictable for these tests
    :rand.seed(:exsplus, {100, 101, 102})
    game = Game.new()
    player1 = Player.new("test1")
    player2 = Player.new("test2")

    [
      player1: player1,
      player2: player2,
      game: game,
      game_with_players: game |> Game.spawn_player(player1) |> Game.spawn_player(player2)
    ]
  end

  describe "new/0" do
    test "it creates a new game on a 10x10 arena", context do
      assert length(Map.keys(context.game.arena)) == 10
      assert length(Map.keys(context.game.arena[0])) == 10
    end
  end

  describe "spawn_player/2" do
    test "it adds a new player to the game on a walkable grid_square", context do
      # the seed that we assigned the :rand function above means we know the grid_ref here
      grid_ref = {2, 3}
      player = context.player1
      arena = context.game_with_players.arena

      player_grid_square = GridSquare.find_by_grid_ref(arena, grid_ref)

      assert player_grid_square.players == %{player.tag => player}
    end
  end

  describe "players/2" do
    test "it returns a list of grid_refs and the players occupying them", context do
      assert Game.players(context.game_with_players) == [
               %{grid_ref: {2, 3}, players: [context.player1]},
               %{grid_ref: {7, 7}, players: [context.player2]}
             ]
    end
  end
end
