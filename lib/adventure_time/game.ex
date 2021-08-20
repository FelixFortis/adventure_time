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

  def add_player(game, player_name) do
    player = Player.new(player_name)

    game
    |> put_in([Access.key(:players), player.tag], player)
  end
end
