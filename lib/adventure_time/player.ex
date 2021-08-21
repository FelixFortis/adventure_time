defmodule AdventureTime.Player do
  alias AdventureTime.Player
  alias AdventureTime.Arena

  @enforce_keys [:name, :grid_ref]
  defstruct [:name, :grid_ref, :tag, :alive, :respawnable]

  def new(game, name) do
    tag = name |> String.replace(" ", "_") |> String.to_atom()

    %Player{
      name: name,
      tag: tag,
      grid_ref: Arena.random_walkable_grid_ref(game.arena),
      alive: true,
      respawnable: false
    }
  end

  # def respawn(player) do
  # end

  # def move_to(player, grid_ref) do
  # end

  # def attack(player) do
  # end
end
