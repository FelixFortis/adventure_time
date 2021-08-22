defmodule AdventureTime.Game do
  alias AdventureTime.{Game, Arena}

  @enforce_keys [:arena]
  defstruct [:arena]

  def new do
    %Game{
      arena: Arena.arena()
    }
  end

  def spawn_player(game, player) do
    game
    |> add_player_to_grid_square(player)
  end

  defp add_player_to_grid_square(game, player) do
    {eastings, northings} = Arena.random_walkable_grid_ref(game.arena)

    game
    |> put_in(
      [
        Access.key(:arena),
        Access.key(eastings),
        Access.key(northings),
        Access.key(:players),
        Access.key(player.tag)
      ],
      player
    )
  end
end
