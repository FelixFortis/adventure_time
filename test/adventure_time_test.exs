defmodule AdventureTimeTest do
  use ExUnit.Case, async: true
  doctest AdventureTime

  describe "start_link/2" do
    test "spawning a game server process" do
      # game_name = :adventure_time_game

      # assert {:ok, _pid} = GameServer.start_link(game_name)
    end
  end
end
