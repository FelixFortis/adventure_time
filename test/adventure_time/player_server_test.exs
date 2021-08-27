defmodule PlayerServerTest do
  use ExUnit.Case, async: true

  doctest AdventureTime.PlayerServer

  alias AdventureTime.{Player, PlayerServer}

  setup do
    [
      player_name: Player.random_name()
    ]
  end

  test "spawning a player server process", context do
    assert({:ok, _pid} = PlayerServer.start_link(context.player_name))
  end

  test "player processes are unique by name", context do
    assert {:ok, _pid} = PlayerServer.start_link(context.player_name)

    assert {:error, _reason} = PlayerServer.start_link(context.player_name)
  end
end
