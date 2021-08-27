defmodule AdventureTime.GameDisplay do
  @moduledoc """
  A module for the purposes of rendering the game in IEX to aid development
  """

  alias AdventureTime.{Arena}

  def render_game(player) do
    IO.write("\n")
    render_arena(player)
    IO.write("\n")
    render_player_info()
    IO.write("\n")
  end

  defp render_arena(player) do
    Arena.game_tiles_as_flattened_list()
    |> Enum.chunk_every(10)
    |> Enum.each(fn arena_row ->
      render_arena_row(arena_row, player)
    end)
  end

  defp render_arena_row(row, player) do
    row
    |> Enum.each(fn game_tile ->
      render_game_tile(game_tile, player)
    end)

    IO.write("\n")
  end

  defp render_game_tile(game_tile, _player) do
    cond do
      game_tile.walkable == false ->
        IO.write("#{IO.ANSI.blue_background()}   #{IO.ANSI.reset()}")

      # length(Map.keys(game_tile.players)) > 1 && game_tile.players[player.tag] == player ->
      #   IO.write("#{IO.ANSI.yellow_background()}   #{IO.ANSI.reset()}")

      # game_tile.players[player.tag] == player ->
      #   IO.write("#{IO.ANSI.green_background()}   #{IO.ANSI.reset()}")

      # length(Map.keys(game_tile.players)) > 0 ->
      #   IO.write("#{IO.ANSI.red_background()}   #{IO.ANSI.reset()}")

      true ->
        IO.write("#{IO.ANSI.white_background()}   #{IO.ANSI.reset()}")
    end
  end

  defp render_player_info do
    # retrieve players from registry?
  end
end
