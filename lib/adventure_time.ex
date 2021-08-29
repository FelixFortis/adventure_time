defmodule AdventureTime do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: AdventureTime.HeroRegistry},
      AdventureTime.HeroSupervisor
    ]

    :ets.new(:heroes_table, [:public, :named_table])

    opts = [strategy: :one_for_one, name: AdventureTime.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
