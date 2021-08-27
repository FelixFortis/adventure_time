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

  describe "spawning a player server process" do
    test "spawns a player server successfully", context do
      assert({:ok, _pid} = PlayerServer.start_link(context.player_name))
    end

    test "player processes are unique by name", context do
      assert {:ok, _pid} = PlayerServer.start_link(context.player_name)

      assert {:error, _reason} = PlayerServer.start_link(context.player_name)
    end
  end

  describe "returning player attributes" do
    test "finding a player's game_tile location", context do
      {:ok, _pid} = PlayerServer.start_link(context.player_name, context.seed)
      player_tile_ref = PlayerServer.tile_ref(context.player_name)

      assert player_tile_ref == {2, 3}
    end

    test "finding a player's alive status", context do
      {:ok, _pid} = PlayerServer.start_link(context.player_name, context.seed)
      player_alive_status = PlayerServer.alive?(context.player_name)

      assert player_alive_status == true
    end
  end

  describe "moving a player" do
    test "to an adjacent walkable game_tile", context do
      {:ok, _pid} = PlayerServer.start_link(context.player_name, context.seed)
      new_tile_ref = {2, 4}
      moved_player = PlayerServer.move_to(context.player_name, new_tile_ref)

      assert moved_player.tile_ref == {2, 4}
    end

    test "to a non-adjacent game_tile", context do
      {:ok, _pid} = PlayerServer.start_link(context.player_name, context.seed)
      new_tile_ref = {2, 5}
      moved_player = PlayerServer.move_to(context.player_name, new_tile_ref)

      assert moved_player.tile_ref == {2, 3}
    end

    test "to an adjacent non-walkable game_tile", context do
      {:ok, _pid} = PlayerServer.start_link(context.player_name, context.seed)
      new_tile_ref = {1, 3}
      moved_player = PlayerServer.move_to(context.player_name, new_tile_ref)

      assert moved_player.tile_ref == {2, 3}
    end
  end
end
