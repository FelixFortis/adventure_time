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
  The player spawn location will be random.
  """
  def start_link(player_name) do
    GenServer.start_link(
      __MODULE__,
      player_name,
      name: via_player_registry(player_name)
    )
  end

  @doc """
  Spawns a new player server process registered under the given `player_name`.
  The player spawn location will be predictably random based on the passed in `seed`.
  """
  def start_link(player_name, seed) do
    GenServer.start_link(
      __MODULE__,
      {player_name, seed},
      name: via_player_registry(player_name)
    )
  end

  def tile_ref(player_name) do
    GenServer.call(via_player_registry(player_name), :tile_ref)
  end

  @doc """
  Returns a tuple which registers and looks up a player server process by `player_name`.
  """
  def via_player_registry(player_name) do
    {:via, Registry, {AdventureTime.PlayerRegistry, player_name}}
  end

  @doc """
  Returns the `pid` of the player server process registered under the
  passed in `player_name`, or `nil` if no process is registered.
  """
  def player_pid(player_name) do
    player_name
    |> via_player_registry()
    |> GenServer.whereis()
  end

  # Server functions

  # we can optionally pass a seed when we need to ensure the randomness is predictable, for example during testing
  def init({player_name, seed}) do
    :rand.seed(:exsplus, seed)

    init(player_name)
  end

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

  def handle_call(:tile_ref, _from, player) do
    {:reply, player.tile_ref, player, @timeout}
  end
end
