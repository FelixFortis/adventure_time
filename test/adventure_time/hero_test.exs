defmodule AdventureTime.HeroTest do
  use ExUnit.Case, async: true

  alias AdventureTime.{Hero, HeroServer}

  doctest Hero

  setup do
    [
      hero: Hero.new("test hero", {6, 4}),
      hero_name: Hero.random_name(),
      hero_name2: Hero.random_name(),
      seed: {100, 101, 102},
      seed2: {100, 101, 103}
    ]
  end

  describe "new/2" do
    test "it creates a new hero at the given location", context do
      assert context.hero == %Hero{
               name: "test hero",
               tile_ref: {6, 4},
               alive: true
             }
    end
  end

  describe "move_to/2" do
    test "it updates the hero's location when moving to an adjacent walkable tile", context do
      assert Hero.move_to(context.hero, {6, 5}) == %Hero{
               name: "test hero",
               tile_ref: {6, 5},
               alive: true
             }
    end

    test "it doesn't update the hero's location when moving to a non-adjacent tile", context do
      assert Hero.move_to(context.hero, {6, 6}) == %Hero{
               name: "test hero",
               tile_ref: {6, 4},
               alive: true
             }
    end

    test "it doesn't update the hero's location when moving to an adjacent non-walkable tile",
         context do
      assert Hero.move_to(context.hero, {6, 3}) == %Hero{
               name: "test hero",
               tile_ref: {6, 4},
               alive: true
             }
    end
  end

  describe "die_and_respawn/2" do
    test "the hero respawns on a different random tile", context do
      # for this test we need to ensure the randomness is predictable
      :rand.seed(:exsplus, {100, 101, 102})

      assert Hero.die_and_respawn(context.hero, {2, 3}) == %Hero{
               name: "test hero",
               tile_ref: {2, 4},
               alive: true
             }
    end
  end
end
