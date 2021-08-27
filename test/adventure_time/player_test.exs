defmodule AdventureTime.PlayerTest do
  use ExUnit.Case, async: true

  alias AdventureTime.{Player}

  doctest Player

  setup do
    [
      player: Player.new("test player", {6, 4})
    ]
  end

  describe "new/2" do
    test "it creates a new player at the given location", context do
      assert context.player == %Player{
               name: "test player",
               tile_ref: {6, 4},
               alive: true
             }
    end
  end

  describe "move_to/2" do
    test "it updates the player's location when moving to an adjacent walkable tile", context do
      assert Player.move_to(context.player, {6, 5}) == %Player{
               name: "test player",
               tile_ref: {6, 5},
               alive: true
             }
    end

    test "it doesn't update the player's location when moving to a non-adjacent tile", context do
      assert Player.move_to(context.player, {6, 6}) == %Player{
               name: "test player",
               tile_ref: {6, 4},
               alive: true
             }
    end

    test "it doesn't update the player's location when moving to an adjacent non-walkable tile",
         context do
      assert Player.move_to(context.player, {6, 3}) == %Player{
               name: "test player",
               tile_ref: {6, 4},
               alive: true
             }
    end
  end

  describe "die_and_respawn/1" do
    test "the player is set to dead", context do
      # for this test we need to ensure the randomness is predictable
      :rand.seed(:exsplus, {100, 101, 102})

      assert Player.die_and_respawn(context.player) == %Player{
               name: "test player",
               tile_ref: {2, 3},
               alive: true
             }
    end
  end
end
