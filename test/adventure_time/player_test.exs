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
               tag: :test_player,
               tile_ref: {6, 4}
             }
    end
  end

  describe "move_to/2" do
    test "it updates the player's location when moving to an adjacent walkable tile", context do
      assert Player.move_to(context.player, {6, 5}) == %Player{
               name: "test player",
               tag: :test_player,
               tile_ref: {6, 5}
             }
    end

    test "it doesn't update the player's location when moving to a non-adjacent tile", context do
      assert Player.move_to(context.player, {6, 6}) == %Player{
               name: "test player",
               tag: :test_player,
               tile_ref: {6, 4}
             }
    end

    test "it doesn't update the player's location when moving to an adjacent non-walkable tile",
         context do
      assert Player.move_to(context.player, {6, 3}) == %Player{
               name: "test player",
               tag: :test_player,
               tile_ref: {6, 4}
             }
    end
  end
end
