defmodule HeroServerTest do
  use ExUnit.Case, async: true

  doctest AdventureTime.HeroServer

  alias AdventureTime.{Hero, HeroServer}

  setup do
    Application.stop(:adventure_time)
    :ok = Application.start(:adventure_time)
  end

  setup do
    seed = {100, 101, 102}
    :rand.seed(:exsplus, seed)
    hero_name = Hero.random_name()
    hero_name_2 = Hero.random_name()
    enemy_hero_name = Hero.random_name()

    [
      hero_name: hero_name,
      hero_name_2: hero_name_2,
      enemy_hero_name: enemy_hero_name,
      seed: seed
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

  describe "all_heroes/0" do
    test "it returns a list of all heroes in play", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      {:ok, _pid} = HeroServer.start_link(context.hero_name_2, context.seed)

      assert length(HeroServer.all_heroes()) >= 2
      assert hd(HeroServer.all_heroes()).__struct__ == Hero
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
      HeroServer.move_to(context.hero_name, new_tile_ref)
      moved_hero_tile_ref = HeroServer.tile_ref(context.hero_name)

      assert moved_hero_tile_ref == {2, 4}
    end

    test "to a non-adjacent game_tile should fail", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      new_tile_ref = {2, 5}
      HeroServer.move_to(context.hero_name, new_tile_ref)
      moved_hero_tile_ref = HeroServer.tile_ref(context.hero_name)

      assert moved_hero_tile_ref == {2, 3}
    end

    test "to an adjacent non-walkable game_tile should fail", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      new_tile_ref = {1, 3}
      HeroServer.move_to(context.hero_name, new_tile_ref)
      moved_hero_tile_ref = HeroServer.tile_ref(context.hero_name)

      assert moved_hero_tile_ref == {2, 3}
    end
  end

  describe "a hero dying and respawning" do
    test "the hero reappears on a random walkable tile", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      current_hero_tile_ref = HeroServer.tile_ref(context.hero_name)
      HeroServer.die_and_respawn(context.hero_name)
      new_hero_tile_ref = HeroServer.tile_ref(context.hero_name)

      assert current_hero_tile_ref != new_hero_tile_ref
    end
  end

  describe "a hero attacking other heroes" do
    test "when the enemy hero is on the same tile as our hero, they die and respawn", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      {:ok, _pid} = HeroServer.start_link(context.enemy_hero_name, context.seed)

      current_enemy_tile_ref = HeroServer.tile_ref(context.enemy_hero_name)

      HeroServer.attack(context.hero_name)

      new_enemy_tile_ref = HeroServer.tile_ref(context.enemy_hero_name)

      assert current_enemy_tile_ref != new_enemy_tile_ref
    end

    test "when the enemy hero is on an adjacent tile to our hero, they die and respawn",
         context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      {:ok, _pid} = HeroServer.start_link(context.enemy_hero_name, context.seed)

      HeroServer.move_to(context.enemy_hero_name, {2, 4})
      current_enemy_tile_ref = HeroServer.tile_ref(context.enemy_hero_name)

      HeroServer.attack(context.hero_name)

      new_enemy_tile_ref = HeroServer.tile_ref(context.enemy_hero_name)

      assert current_enemy_tile_ref != new_enemy_tile_ref
    end

    test "when the enemy hero is not on an adjacent tile to our hero, they are unaffected by our hero's attack",
         context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      {:ok, _pid} = HeroServer.start_link(context.enemy_hero_name, context.seed)

      HeroServer.move_to(context.enemy_hero_name, {2, 4})
      HeroServer.move_to(context.enemy_hero_name, {2, 5})
      current_enemy_tile_ref = HeroServer.tile_ref(context.enemy_hero_name)

      HeroServer.attack(context.hero_name)

      new_enemy_tile_ref = HeroServer.tile_ref(context.enemy_hero_name)

      assert current_enemy_tile_ref == new_enemy_tile_ref
    end
  end
end
