defmodule AdventureTime.GameDisplay do
  alias AdventureTime.Arena

  def render_game(game) do
    IO.write("\n")
    render_arena(game.arena)
    IO.write("\n")
    render_player_info(game.players)
    IO.write("\n")
  end

  defp render_arena(arena) do
    arena
    |> Arena.grid_squares_as_flattened_list()
    |> Enum.chunk_every(10)
    |> Enum.each(fn arena_row ->
      render_arena_row(arena_row)
    end)
  end

  defp render_arena_row(row) do
    row
    |> Enum.each(fn grid_square ->
      if grid_square.walkable == false do
        IO.write("#{IO.ANSI.blue_background()}   #{IO.ANSI.reset()}")
      else
        IO.write("#{IO.ANSI.white_background()}   #{IO.ANSI.reset()}")
      end
    end)

    IO.write("\n")
  end

  defp render_player_info(players) do
    players
    |> Enum.each(fn {_tag, player} ->
      IO.puts("#{player.name} - {#{elem(player.grid_ref, 0)}, #{elem(player.grid_ref, 1)}}")
    end)
  end
end
