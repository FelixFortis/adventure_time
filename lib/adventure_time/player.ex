defmodule AdventureTime.Player do
  @moduledoc """
  A player struct and the main component of the game - contains the location and status of the player
  Module contains functions around player actions like movement.
  """

  alias AdventureTime.{Player, GameTile, Arena}

  @enforce_keys [:name]
  defstruct [:name, :tag, :tile_ref, :alive]

  @adjectives Application.get_env(:adventure_time, :adjectives)
  @nouns Application.get_env(:adventure_time, :nouns)

  def new(name \\ "", tile_ref) do
    player_name = set_player_name(name)
    tag = parse_player_tag(player_name)

    %Player{
      name: player_name,
      tag: tag,
      tile_ref: tile_ref,
      alive: true
    }
  end

  def die_and_respawn(player) do
    player
    |> mark_as_dead()
    |> respawn_cooldown()
    |> mark_as_alive()
    |> respawn()
  end

  def move_to(player, new_tile_ref) do
    if GameTile.walkable?(new_tile_ref) && Arena.adjacent?(player.tile_ref, new_tile_ref) do
      player
      |> insert_at(new_tile_ref)
    else
      player
    end
  end

  def random_name(range \\ 9999, delimiter \\ "_") do
    :rand.seed(:exsplus)
    token = if range > 0, do: random(range)

    [@adjectives, @nouns]
    |> Enum.map(&sample/1)
    |> Enum.concat(List.wrap(token))
    |> Enum.join(delimiter)
  end

  defp mark_as_dead(player) do
    player
    |> Map.put(:alive, false)
  end

  defp mark_as_alive(player) do
    player
    |> Map.put(:alive, true)
  end

  defp respawn_cooldown(player) do
    :timer.seconds(5)
    player
  end

  defp respawn(player) do
    player
    |> insert_at(Arena.random_walkable_tile_ref())
  end

  defp insert_at(player, new_tile_ref) do
    player
    |> Map.put(:tile_ref, new_tile_ref)
  end

  defp random(range) when range > 0, do: :rand.uniform(range)

  defp sample(array), do: Enum.random(array)

  defp parse_player_tag(player_name) do
    player_name
    |> String.downcase()
    |> String.replace(" ", "_")
    |> String.to_atom()
  end

  defp set_player_name(name) do
    case name do
      "" ->
        random_name()

      chosen_name ->
        chosen_name
    end
  end
end
