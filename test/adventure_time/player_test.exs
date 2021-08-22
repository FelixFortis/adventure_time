defmodule AdventureTime.PlayerTest do
  use ExUnit.Case, async: true

  alias AdventureTime.{Game, Player}

  doctest Player

  describe "new/0" do
    test "it creates a new player" do
      player = Player.new("test")

      assert player == %Player{
               name: "test",
               tag: :test
             }
    end
  end
end
