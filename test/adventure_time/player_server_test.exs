defmodule PlayerServerTest do
  use ExUnit.Case, async: true

  doctest AdventureTime.PlayerServer

  alias AdventureTime.{Player, PlayerServer}

  setup do
    [
      player_name: Player.random_name(),
      seed: {100, 101, 102}
    ]
  end

  test "spawning a player server process", context do
    assert({:ok, _pid} = PlayerServer.start_link(context.player_name))
  end

  test "player processes are unique by name", context do
    assert {:ok, _pid} = PlayerServer.start_link(context.player_name)

    assert {:error, _reason} = PlayerServer.start_link(context.player_name)
  end

  test "finding a player's game_tile location", context do
    {:ok, _pid} = PlayerServer.start_link(context.player_name, context.seed)

    player_tile_ref = PlayerServer.tile_ref(context.player_name)

    assert player_tile_ref == {2, 3}
  end
end
