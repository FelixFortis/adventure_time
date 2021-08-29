# AdventureTime

A standalone, grid-based game that players can join, move around on and attack each other. This can be run on any client, although this [Phoenix application](https://github.com/felixfortis/adventure_time_online) is recommended as a good online interface. There is a `GameDisplay` module for working in the console when developing the application itself.

## Installation

Add the following line to your to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:adventure_time, git: "git@github.com:felixfortis/adventure_time.git", tag: "0.1.0"}
  ]
end
```

## Usage

1. Create a few heroes:

```elixir
iex> AdventureTime.HeroSupervisor.start_hero("test_hero_1")
iex> AdventureTime.HeroSupervisor.start_hero("test_hero_2")
```

2. Use the `GameDisplay` module in the console for a basic view of the game from the point of view of the passed in hero:

```elixir
iex> AdventureTime.GameDisplay.render_game("test_hero_1")
```

3. Make changes to the heroes and render the game again to see the results:

```elixir
# Note that heroes can only move one tile at a time, and only on "walkable" tiles.
# Consult AdventureTime.Arena.arena() to see which tiles are walkable and what their tile_refs are.
# This assumes that "test_hero_1" is somewhere like {4, 6} and wants to move up one tile to {3, 6}
iex> AdventureTime.HeroServer.move_to("test_hero_1", {3, 6})
iex> AdventureTime.GameDisplay.render_game("test_hero_1")
```
## Contributing

1. Clone the project to your development machine
2. Install dependencies with `mix deps.get`
3. Run the tests with `mix test`
