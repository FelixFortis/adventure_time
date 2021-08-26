defmodule AdventureTime.PlayerTest do
  use ExUnit.Case, async: true

  alias AdventureTime.{Player}

  doctest Player

  setup do
    [
      player: Player.new("test player", {5, 6})
    ]
  end

  describe "new/2" do
    test "it creates a new player at the given location", context do
      assert context.player == %Player{
               name: "test player",
               tag: :test_player,
               tile_ref: {5, 6}
             }
    end
  end

  describe "move_to/2" do
    test "it updates the player's location", context do
      assert Player.move_to(context.player, {5, 7}) == %Player{
               name: "test player",
               tag: :test_player,
               tile_ref: {5, 7}
             }
    end
  end
end
