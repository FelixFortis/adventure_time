defmodule AdventureTime.GameTest do
  use ExUnit.Case, async: true

  alias AdventureTime.{Game, Player, GridSquare}

  doctest Game

  setup do
    # ensure the random placement is predictable for these tests
    :rand.seed(:exsplus, {100, 101, 102})
    game = Game.new()
    player = Player.new("test")

    [
      player: player,
      game: game,
      game_with_player: game |> Game.spawn_player(player)
    ]
  end

  describe "new/0" do
    test "it creates a new game on a 10x10 arena" do
      game = Game.new()
      assert length(Map.keys(game.arena)) == 10
      assert length(Map.keys(game.arena[0])) == 10
    end
  end

  describe "spawn_player/2" do
    test "it adds a new player to the game on a walkable grid_square", context do
      # the seed that we assigned the :rand function above means we know the grid_ref here
      grid_ref = {2, 3}
      player = context.player
      arena = context.game_with_player.arena

      player_grid_square = GridSquare.find_by_grid_ref(arena, grid_ref)

      assert player_grid_square.players == %{player.tag => player}
    end
  end
end
