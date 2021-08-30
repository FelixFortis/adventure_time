defmodule HeroSupervisorTest do
  use ExUnit.Case, async: true

  doctest AdventureTime.HeroSupervisor

  alias AdventureTime.{HeroSupervisor, HeroServer, Hero, NameGenerator}

  setup do
    hero_name = NameGenerator.generate()

    [
      hero_name: hero_name
    ]
  end

  describe "start_hero" do
    test "it spawns a new HeroServer process", context do
      assert {:ok, _pid} = HeroSupervisor.start_hero(context.hero_name)
      via_registry = HeroServer.via_hero_registry(context.hero_name)

      assert GenServer.whereis(via_registry) |> Process.alive?()
    end

    test "it returns an error if a HeroServer of the same name already exists", context do
      assert {:ok, pid} = HeroSupervisor.start_hero(context.hero_name)
      assert {:error, {:already_started, ^pid}} = HeroSupervisor.start_hero(context.hero_name)
    end
  end

  describe "stop_hero" do
    test "it terminates the process normally and doesn't restart it", context do
      {:ok, _pid} = HeroSupervisor.start_hero(context.hero_name)
      via_registry = HeroServer.via_hero_registry(context.hero_name)

      assert :ok = HeroSupervisor.stop_hero(context.hero_name)
      refute GenServer.whereis(via_registry)
    end
  end
end
