defmodule AdventureTime do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Registry, keys: :unique, name: AdventureTime.PlayerRegistry}
      # AdventureTime.PlayerSupervisor
    ]

    opts = [strategy: :one_for_one, name: AdventureTime.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
