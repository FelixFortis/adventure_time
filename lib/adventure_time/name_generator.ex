defmodule AdventureTime.NameGenerator do
  def generate() do
    token = random(9999)

    [adjectives(), nouns()]
    |> Enum.map(&sample/1)
    |> Enum.concat(List.wrap(token))
    |> Enum.join("_")
  end

  defp adjectives do
    ~w(
      autumn hidden bitter misty silent empty dry dark summer
      icy delicate quiet white cool spring winter patient
      twilight dawn crimson wispy weathered blue billowing
      broken cold damp falling frosty green long late lingering
      bold little morning muddy old red rough still small
      sparkling throbbing shy wandering withered wild black
      young holy solitary fragrant aged snowy proud floral
      restless divine polished ancient purple lively nameless
    )
  end

  defp nouns do
    ~w(
      waterfall river breeze moon rain wind sea morning
      snow lake sunset pine shadow leaf dawn glitter forest
      hill cloud meadow sun glade bird brook butterfly
      bush dew dust field fire flower firefly feather grass
      haze mountain night pond darkness snowflake silence
      sound sky shape surf thunder violet water wildflower
      wave water resonance sun wood dream cherry tree fog
      frost voice paper frog smoke star
    )
  end

  defp random(range) when range > 0, do: :rand.uniform(range)

  defp sample(array), do: Enum.random(array)
end
