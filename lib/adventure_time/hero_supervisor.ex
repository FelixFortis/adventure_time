defmodule AdventureTime.HeroSupervisor do
  @moduledoc """
  A supervisor for dynamically starting `HeroServer` processes
  """

  use DynamicSupervisor

  alias AdventureTime.HeroServer

  def start_link(_arg) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  @doc """
  Launches and supervises a `HeroServer` process
  """
  def start_hero(hero_name) do
    hero_spec = %{
      id: HeroServer,
      start: {HeroServer, :start_link, [hero_name]},
      restart: :transient
    }

    DynamicSupervisor.start_child(__MODULE__, hero_spec)
  end

  @doc """
  Terminates the `HeroServer` process normally (no restarts)
  """
  def stop_hero(hero_name) do
    :ets.delete(:heroes_table, hero_name)

    hero_pid = HeroServer.hero_pid(hero_name)
    DynamicSupervisor.terminate_child(__MODULE__, hero_pid)
  end
end
