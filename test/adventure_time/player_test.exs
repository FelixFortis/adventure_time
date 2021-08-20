defmodule AdventureTime.PlayerTest do
  use ExUnit.Case, async: true

  alias AdventureTime.Player

  doctest Player

  describe "new/0" do
    test "it creates a new player assigned to a random grid" do
      :rand.seed(:exsplus, {100, 101, 102})
      player = Player.new("test")
      assert player == %Player{grid_ref: {2, 3}, name: "test", tag: :test}
    end
  end
end
