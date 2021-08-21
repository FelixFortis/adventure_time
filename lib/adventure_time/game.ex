defmodule AdventureTime.Game do
  alias AdventureTime.{Game, Arena, Player}

  @enforce_keys [:arena, :players]
  defstruct [:arena, :players]

  def new do
    %Game{
      players: %{},
      arena: Arena.grid()
    }
  end

  def spawn_player(game, player_name) do
    player = Player.new(game, player_name)
    player_eastings = elem(player.grid_ref, 0)
    player_northings = elem(player.grid_ref, 1)

    game
    |> put_in([Access.key(:players), Access.key(player.tag)], player)
    |> put_in(
      [
        Access.key(:arena),
        Access.key(player_eastings),
        Access.key(player_northings),
        Access.key(:players),
        Access.key(player.tag)
      ],
      player
    )
  end
end
