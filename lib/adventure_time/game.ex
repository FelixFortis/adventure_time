defmodule AdventureTime.Game do
  alias AdventureTime.Game
  alias AdventureTime.Arena

  @enforce_keys [:arena, :players]
  defstruct [:arena, :players]

  def new do
    %Game{
      players: [],
      arena: Arena.grid()
    }
  end
end
