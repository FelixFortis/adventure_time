defmodule AdventureTime.PlayerTest do
  use ExUnit.Case, async: true

  alias AdventureTime.{Game, Player}

  doctest Player

  describe "new/0" do
    test "it creates a new player assigned to a random grid" do
      :rand.seed(:exsplus, {100, 101, 102})
      game = Game.new()
      player = Player.new(game, "test")

      assert player == %Player{
               grid_ref: {2, 3},
               name: "test",
               tag: :test,
               alive: true,
               respawnable: false
             }
    end
  end
end
