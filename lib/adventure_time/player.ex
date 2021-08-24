defmodule AdventureTime.Player do
  alias AdventureTime.Player

  @enforce_keys [:name]
  defstruct [:name, :tag]

  def new(name) do
    tag =
      name
      |> String.downcase()
      |> String.replace(" ", "_")
      |> String.to_atom()

    %Player{
      name: name,
      tag: tag
    }
  end
end
