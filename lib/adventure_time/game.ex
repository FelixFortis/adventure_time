defmodule AdventureTime.Game do
  alias AdventureTime.{Game, Arena, GridSquare}

  @enforce_keys [:arena]
  defstruct [:arena]

  def new do
    %Game{
      arena: Arena.arena()
    }
  end

  def spawn_player(game, player) do
    game
    |> add_player_to_random_grid_square(player)
  end

  def players(game) do
    game.arena
    |> Arena.grid_squares_as_flattened_list()
    |> Enum.map(fn grid_square ->
      %{grid_ref: grid_square.grid_ref, players: Map.values(grid_square.players)}
    end)
    |> Enum.filter(fn %{grid_ref: _grid_ref, players: player_list} -> length(player_list) > 0 end)
  end

  def move_player_to(game, player, new_grid_ref) do
    player_grid_ref = Arena.player_grid_ref(game.arena, player)

    if GridSquare.walkable?(game.arena, new_grid_ref) do
      game
      |> remove_player_from_grid_square(player, player_grid_ref)
      |> add_player_to_grid_square(player, new_grid_ref)
    else
      game
    end
  end

  defp add_player_to_random_grid_square(game, player) do
    {y_axis, x_axis} = Arena.random_walkable_grid_ref(game.arena)

    game
    |> put_in(
      [
        Access.key(:arena),
        Access.key(y_axis),
        Access.key(x_axis),
        Access.key(:players),
        Access.key(player.tag)
      ],
      player
    )
  end

  defp add_player_to_grid_square(game, player, grid_ref) do
    {y_axis, x_axis} = grid_ref

    game
    |> put_in(
      [
        Access.key(:arena),
        Access.key(y_axis),
        Access.key(x_axis),
        Access.key(:players),
        Access.key(player.tag)
      ],
      player
    )
  end

  defp remove_player_from_grid_square(game, player, grid_ref) do
    {y_axis, x_axis} = grid_ref

    {_, updated_game} =
      game
      |> pop_in([
        Access.key(:arena),
        Access.key(y_axis),
        Access.key(x_axis),
        Access.key(:players),
        Access.key(player.tag)
      ])

    updated_game
  end
end
