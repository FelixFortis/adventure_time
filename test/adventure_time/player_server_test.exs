defmodule PlayerServerTest do
  use ExUnit.Case, async: true

  doctest AdventureTime.PlayerServer

  alias AdventureTime.{Player, PlayerServer}

  test "spawning a player server process" do
    name = Player.random_name()

    assert({:ok, _pid} = PlayerServer.start_link(name))
  end
end
