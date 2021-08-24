defmodule AdventureTime.GridSquareTest do
  use ExUnit.Case, async: true

  alias AdventureTime.{Game, GridSquare, Player}

  doctest GridSquare

  setup do
    mock_arena = %{
      0 => %{
        0 => %GridSquare{
          grid_ref: {0, 0},
          walkable: false,
          players: %{
            test1: %Player{name: "test1", tag: :test1},
            test2: %Player{name: "test2", tag: :test2}
          }
        },
        1 => %GridSquare{grid_ref: {0, 1}, walkable: false, players: %{}}
      },
      1 => %{
        0 => %GridSquare{grid_ref: {1, 0}, walkable: false, players: %{}},
        1 => %GridSquare{
          grid_ref: {1, 1},
          walkable: true,
          players: %{
            test3: %Player{name: "test3", tag: :test3}
          }
        }
      }
    }

    [
      game: Game.new(),
      mock_arena: mock_arena
    ]
  end

  describe "find_by_grid_ref/2" do
    test "it returns the grid_square with the passed in grid_ref", context do
      assert GridSquare.find_by_grid_ref(context.mock_arena, {1, 0}) == %GridSquare{
               grid_ref: {1, 0},
               walkable: false,
               players: %{}
             }
    end
  end

  describe "players/2" do
    test "it returns a map of the players that currently occupy the grid_square", context do
      assert GridSquare.players(context.mock_arena, {0, 0}) == %{
               test1: %AdventureTime.Player{name: "test1", tag: :test1},
               test2: %AdventureTime.Player{name: "test2", tag: :test2}
             }
    end
  end

  describe "walkable?/2" do
    test "it returns true for a walkable grid square", context do
      assert GridSquare.walkable?(context.mock_arena, {1, 1}) == true
    end

    test "it returns false for an unwalkable grid square", context do
      assert GridSquare.walkable?(context.mock_arena, {0, 1}) == false
    end
  end

  describe "interactable_grid_refs/2" do
    test "it returns a list of grid_refs - the given grid_ref and all adjacent walkable grid_refs",
         context do
      assert GridSquare.interactable_grid_refs(context.game.arena, {5, 2}) == [
               {4, 1},
               {4, 2},
               {4, 3},
               {5, 1},
               {5, 2},
               {5, 3},
               {6, 1}
             ]
    end
  end
end
