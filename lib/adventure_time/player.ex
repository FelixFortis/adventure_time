defmodule AdventureTime.Player do
  alias AdventureTime.Player
  alias AdventureTime.Arena

  @enforce_keys [:name, :grid_ref]
  defstruct [:name, :grid_ref, :tag]

  def new(name) do
    tag = name |> String.replace(" ", "_") |> String.to_atom()

    %Player{name: name, tag: tag, grid_ref: Arena.random_walkable_grid_ref()}
  end
end
