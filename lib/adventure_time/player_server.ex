defmodule AdventureTime.PlayerServer do
  @moduledoc """
  A player server process that holds a `Player` struct as its state.
  """

  use GenServer

  require Logger

  @timeout :timer.minutes(45)

  # Public API

  @doc """
  Spawns a new player server process registered under the given `player_name`.
  """
  def start_link(player_name) do
    GenServer.start_link(
      __MODULE__,
      player_name,
      name: via_tuple(player_name)
    )
  end

  @doc """
  Returns a tuple which registers and looks up a player server process by `player_name`.
  """
  def via_tuple(player_name) do
    {:via, Registry, {AdventureTime.PlayerRegistry, player_name}}
  end

  @doc """
  Returns the `pid` of the player server process registered under the
  passed in `player_name`, or `nil` if no process is registered.
  """
  def player_pid(player_name) do
    player_name
    |> via_tuple()
    |> GenServer.whereis()
  end

  # Server functions

  def init(player_name) do
    player =
      case :ets.lookup(:players_table, player_name) do
        [] ->
          player =
            AdventureTime.Player.new(player_name, AdventureTime.Arena.random_walkable_tile_ref())

          :ets.insert(:players_table, {player_name, player})
          player

        [{^player_name, player}] ->
          player
      end

    {:ok, player, @timeout}
  end
end
