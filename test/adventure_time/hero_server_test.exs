defmodule HeroServerTest do
  use ExUnit.Case, async: true

  doctest AdventureTime.HeroServer

  alias AdventureTime.{Hero, HeroServer}

  setup do
    [
      hero_name: Hero.random_name(),
      hero_name2: Hero.random_name(),
      seed: {100, 101, 102},
      seed2: {100, 101, 103}
    ]
  end

  describe "spawning a hero server process" do
    test "spawns a hero server successfully", context do
      assert({:ok, _pid} = HeroServer.start_link(context.hero_name))
    end

    test "hero processes are unique by name", context do
      assert {:ok, _pid} = HeroServer.start_link(context.hero_name)

      assert {:error, _reason} = HeroServer.start_link(context.hero_name)
    end
  end

  describe "returning hero attributes" do
    test "finding a hero's game_tile location", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      hero_tile_ref = HeroServer.tile_ref(context.hero_name)

      assert hero_tile_ref == {2, 3}
    end

    test "finding a hero's alive status", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      hero_alive_status = HeroServer.alive?(context.hero_name)

      assert hero_alive_status == true
    end
  end

  describe "moving a hero" do
    test "to an adjacent walkable game_tile", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      new_tile_ref = {2, 4}
      moved_hero = HeroServer.move_to(context.hero_name, new_tile_ref)

      assert moved_hero.tile_ref == {2, 4}
    end

    test "to a non-adjacent game_tile", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      new_tile_ref = {2, 5}
      moved_hero = HeroServer.move_to(context.hero_name, new_tile_ref)

      assert moved_hero.tile_ref == {2, 3}
    end

    test "to an adjacent non-walkable game_tile", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      new_tile_ref = {1, 3}
      moved_hero = HeroServer.move_to(context.hero_name, new_tile_ref)

      assert moved_hero.tile_ref == {2, 3}
    end
  end

  describe "all_heroes/0" do
    test "it returns a list of all heroes in play", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      {:ok, _pid} = HeroServer.start_link(context.hero_name2, context.seed2)

      assert length(HeroServer.all_heroes()) == 2

      assert HeroServer.all_heroes() |> Enum.map(fn hero -> hero.tile_ref end) == [
               {2, 3},
               {5, 4}
             ]
    end
  end
end
