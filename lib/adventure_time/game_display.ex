defmodule AdventureTime.GameDisplay do
  @moduledoc """
  A module for the purposes of rendering the game in IEX to aid development
  """

  alias AdventureTime.{HeroServer, Arena, GameTile}

  def render_game(hero_name) do
    IO.write("\n")
    render_arena(hero_name)
    IO.write("\n")
    render_hero_info(hero_name)
    IO.write("\n")
  end

  defp render_arena(hero_name) do
    Arena.game_tiles_as_flattened_list()
    |> Enum.chunk_every(10)
    |> Enum.each(fn arena_row ->
      render_arena_row(arena_row, hero_name)
    end)
  end

  defp render_arena_row(row, hero_name) do
    row
    |> Enum.each(fn game_tile ->
      render_game_tile(game_tile, hero_name)
    end)

    IO.write("\n")
  end

  defp render_game_tile(game_tile, hero_name) do
    cond do
      game_tile.walkable == false ->
        IO.write("#{IO.ANSI.blue_background()}   #{IO.ANSI.reset()}")

      GameTile.hero_count(game_tile.tile_ref) > 1 && GameTile.heroes_on_tile?(game_tile.tile_ref) &&
          GameTile.hero_on_tile?(game_tile.tile_ref, hero_name) ->
        IO.write("#{IO.ANSI.yellow_background()}   #{IO.ANSI.reset()}")

      GameTile.hero_count(game_tile.tile_ref) == 1 &&
          GameTile.hero_on_tile?(game_tile.tile_ref, hero_name) ->
        IO.write("#{IO.ANSI.green_background()}   #{IO.ANSI.reset()}")

      GameTile.heroes_on_tile?(game_tile.tile_ref) ->
        IO.write("#{IO.ANSI.red_background()}   #{IO.ANSI.reset()}")

      true ->
        IO.write("#{IO.ANSI.white_background()}   #{IO.ANSI.reset()}")
    end
  end

  defp render_hero_info(hero_name) do
    heroes = HeroServer.all_heroes()

    heroes
    |> Enum.sort()
    |> Enum.each(fn hero ->
      if hero.name == hero_name do
        IO.write("#{IO.ANSI.green()}#{hero_info(hero)}#{IO.ANSI.reset()}")
      else
        IO.write(hero_info(hero))
      end
    end)
  end

  defp hero_info(hero) do
    "#{hero.name} - {#{elem(hero.tile_ref, 0)}, #{elem(hero.tile_ref, 1)}}\n"
  end
end
