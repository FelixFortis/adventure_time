defmodule AdventureTime.GameDisplay do
  alias AdventureTime.Arena

  def render_game(game, player) do
    IO.write("\n")
    render_arena(game.arena, player)
    IO.write("\n")
    render_player_info(game.players)
    IO.write("\n")
  end

  defp render_arena(arena, player) do
    arena
    |> Arena.grid_squares_as_flattened_list()
    |> Enum.chunk_every(10)
    |> Enum.each(fn arena_row ->
      render_arena_row(arena_row, player)
    end)
  end

  defp render_arena_row(row, player) do
    row
    |> Enum.each(fn grid_square ->
      render_grid_square(grid_square, player)
    end)

    IO.write("\n")
  end

  defp render_grid_square(grid_square, player) do
    cond do
      grid_square.walkable == false ->
        IO.write("#{IO.ANSI.blue_background()}   #{IO.ANSI.reset()}")

      grid_square.players[player] == player ->
        IO.write("#{IO.ANSI.green_background()}   #{IO.ANSI.reset()}")

      length(Map.keys(grid_square.players)) > 0 ->
        IO.write("#{IO.ANSI.red_background()}   #{IO.ANSI.reset()}")

      true ->
        IO.write("#{IO.ANSI.white_background()}   #{IO.ANSI.reset()}")
    end
  end

  defp render_player_info(players) do
    players
    |> Enum.each(fn {_tag, player} ->
      IO.puts("#{player.name} - {#{elem(player.grid_ref, 0)}, #{elem(player.grid_ref, 1)}}")
    end)
  end
end
