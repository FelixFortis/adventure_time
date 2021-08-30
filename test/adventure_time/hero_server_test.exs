defmodule HeroServerTest do
  use ExUnit.Case, async: true

  doctest AdventureTime.HeroServer

  alias AdventureTime.{Hero, HeroServer, NameGenerator}

  setup do
    Application.stop(:adventure_time)
    :ok = Application.start(:adventure_time)
  end

  setup do
    seed = {100, 101, 102}
    :rand.seed(:exsplus, seed)
    hero_name = NameGenerator.generate()
    hero_name_2 = NameGenerator.generate()
    enemy_hero_name = NameGenerator.generate()

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

  describe "ETS storage of HeroServer stat" do
    test "it stores the initial state of the new HeroServer process", context do
      HeroServer.start_link("stored_hero", context.seed)

      assert :ets.lookup(:heroes_table, "stored_hero") == [
               {"stored_hero",
                %AdventureTime.Hero{alive: true, name: "stored_hero", tile_ref: {2, 3}}}
             ]
    end

    test "it can update the state of the new HeroServer process", context do
      HeroServer.start_link("stored_hero", context.seed)
      HeroServer.move_to("stored_hero", {2, 4})

      assert :ets.lookup(:heroes_table, "stored_hero") == [
               {"stored_hero",
                %AdventureTime.Hero{alive: true, name: "stored_hero", tile_ref: {2, 4}}}
             ]
    end

    test "restarted HeroServer processes restore their state from ETS", context do
      HeroServer.start_link("stored_hero", context.seed)
      HeroServer.start_link("stored_hero", {200, 201, 202})

      assert :ets.lookup(:heroes_table, "stored_hero") == [
               {"stored_hero",
                %AdventureTime.Hero{alive: true, name: "stored_hero", tile_ref: {2, 3}}}
             ]
    end
  end

  describe "hero_pid" do
    test "returns a PID if the HeroServer process has been registered", context do
      {:ok, pid} = HeroServer.start_link(context.hero_name)

      assert ^pid = HeroServer.hero_pid(context.hero_name)
    end

    test "returns nil if the HeroServer process does not exist" do
      refute HeroServer.hero_pid("i_dont_exist")
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
    test "the hero is marked as dead", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name)
      HeroServer.die(context.hero_name)
      refute HeroServer.alive?(context.hero_name)
    end

    test "the hero reappears on a random walkable tile", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      current_hero_tile_ref = HeroServer.tile_ref(context.hero_name)
      HeroServer.die(context.hero_name)
      HeroServer.respawn(context.hero_name)
      new_hero_tile_ref = HeroServer.tile_ref(context.hero_name)

      assert current_hero_tile_ref != new_hero_tile_ref
    end
  end

  describe "a hero attacking other heroes" do
    test "when the enemy hero is on the same tile as our hero, they die", context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      {:ok, _pid} = HeroServer.start_link(context.enemy_hero_name, context.seed)

      HeroServer.attack(context.hero_name)

      refute HeroServer.alive?(context.enemy_hero_name)
    end

    test "when the enemy hero is on an adjacent tile to our hero, they die",
         context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      {:ok, _pid} = HeroServer.start_link(context.enemy_hero_name, context.seed)

      HeroServer.move_to(context.enemy_hero_name, {2, 4})

      HeroServer.attack(context.hero_name)

      refute HeroServer.alive?(context.enemy_hero_name)
    end

    test "when the enemy hero is not on an adjacent tile to our hero, they don't die",
         context do
      {:ok, _pid} = HeroServer.start_link(context.hero_name, context.seed)
      {:ok, _pid} = HeroServer.start_link(context.enemy_hero_name, context.seed)

      HeroServer.move_to(context.enemy_hero_name, {2, 4})
      HeroServer.move_to(context.enemy_hero_name, {2, 5})

      HeroServer.attack(context.hero_name)

      assert HeroServer.alive?(context.enemy_hero_name)
    end
  end
end
