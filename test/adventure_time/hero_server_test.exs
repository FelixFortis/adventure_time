defmodule HeroServerTest do
  use ExUnit.Case, async: true

  doctest AdventureTime.HeroServer

  alias AdventureTime.{Hero, HeroServer}

  setup do
    [
      hero_name: Hero.random_name(),
      seed: {100, 101, 102}
    ]
  end

  describe "spawning a hero server process" do
    test "spawns a hero server successfully", context do
      assert({:ok, _pid} = HeroServer.start_link(context.hero_name))
    end

    test "the hero process is registered as unique using the passed in name", context do
      assert {:ok, _pid} = HeroServer.start_link(context.hero_name)

      assert {:error, _reason} = HeroServer.start_link(context.hero_name)
    end
  end

  describe "querying hero attributes" do
    test "returns a hero's game_tile location", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      hero_tile_ref = HeroServer.tile_ref(context.hero_name)

      assert hero_tile_ref == {2, 3}
    end

    test "returns a hero's alive status", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      hero_alive_status = HeroServer.alive?(context.hero_name)

      assert hero_alive_status == true
    end
  end

  describe "moving a hero" do
    test "to an adjacent walkable game_tile should succeed", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      new_tile_ref = {2, 4}
      moved_hero = HeroServer.move_to(context.hero_name, new_tile_ref)

      assert moved_hero.tile_ref == {2, 4}
    end

    test "to a non-adjacent game_tile should fail", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      new_tile_ref = {2, 5}
      moved_hero = HeroServer.move_to(context.hero_name, new_tile_ref)

      assert moved_hero.tile_ref == {2, 3}
    end

    test "to an adjacent non-walkable game_tile should fail", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      new_tile_ref = {1, 3}
      moved_hero = HeroServer.move_to(context.hero_name, new_tile_ref)

      assert moved_hero.tile_ref == {2, 3}
    end
  end
end
