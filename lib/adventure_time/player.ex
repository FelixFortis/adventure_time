defmodule AdventureTime.Player do
  alias AdventureTime.Player

  @enforce_keys [:name]
  defstruct [:name, :tag, :grid_ref]

  @adjectives Application.get_env(:adventure_time, :adjectives)
  @nouns Application.get_env(:adventure_time, :nouns)

  def new(name \\ "", grid_ref) do
    player_name = set_player_name(name)
    tag = parse_player_tag(player_name)

    %Player{
      name: player_name,
      tag: tag,
      grid_ref: grid_ref
    }
  end

  def move_to(player, new_grid_ref) do
    if GameTile.walkable?(new_grid_ref) do
      player
      |> Map.put(:grid_ref, new_grid_ref)
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
