defmodule AdventureTime.GameDisplay do
  @moduledoc """
  A module for the purposes of rendering the game in IEX to aid development
  """

  alias AdventureTime.{Arena}

  def render_game(hero) do
    IO.write("\n")
    render_arena(hero)
    IO.write("\n")
    render_hero_info()
    IO.write("\n")
  end

  defp render_arena(hero) do
    Arena.game_tiles_as_flattened_list()
    |> Enum.chunk_every(10)
    |> Enum.each(fn arena_row ->
      render_arena_row(arena_row, hero)
    end)
  end

  defp render_arena_row(row, hero) do
    row
    |> Enum.each(fn game_tile ->
      render_game_tile(game_tile, hero)
    end)

    IO.write("\n")
  end

  defp render_game_tile(game_tile, _hero) do
    cond do
      game_tile.walkable == false ->
        IO.write("#{IO.ANSI.blue_background()}   #{IO.ANSI.reset()}")

      # enemies and hero on tile ->
      #   IO.write("#{IO.ANSI.yellow_background()}   #{IO.ANSI.reset()}")

      # hero alone on tile ->
      #   IO.write("#{IO.ANSI.green_background()}   #{IO.ANSI.reset()}")

      # enemies but no hero on tile ->
      #   IO.write("#{IO.ANSI.red_background()}   #{IO.ANSI.reset()}")

      true ->
        IO.write("#{IO.ANSI.white_background()}   #{IO.ANSI.reset()}")
    end
  end

  defp render_hero_info do
    # retrieve heroes from registry?
  end
end
