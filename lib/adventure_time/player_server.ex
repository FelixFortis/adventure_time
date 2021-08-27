defmodule AdventureTime.PlayerServer do
  @moduledoc """
  A player server process that holds a `Player` struct as its state.
  """

  use GenServer

  require Logger

  @timeout :timer.hours(2)

  # Public API

  @doc """
  Spawns a new player server process registered under the given `name`.
  """
  def start_link(name) do
    GenServer.start_link(
      __MODULE__,
      {name},
      name: via_tuple(name)
    )
  end

  @doc """
  Returns a tuple which registers and looks up a player server process by `name`.
  """
  def via_tuple(name) do
    {:via, Registry, {AdventureTime.PlayerRegistry, name}}
  end

  @doc """
  Returns the `pid` of the player server process registered under the
  passed in `name`, or `nil` if no process is registered.
  """
  def player_pid(name) do
    name
    |> via_tuple()
    |> GenServer.whereis()
  end

  # Server functions
end
