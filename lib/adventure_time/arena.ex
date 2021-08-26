defmodule AdventureTime.Arena do
  alias AdventureTime.GameTile

  def arena do
    %{
      0 => %{
        0 => %GameTile{grid_ref: {0, 0}, walkable: false},
        1 => %GameTile{grid_ref: {0, 1}, walkable: false},
        2 => %GameTile{grid_ref: {0, 2}, walkable: false},
        3 => %GameTile{grid_ref: {0, 3}, walkable: false},
        4 => %GameTile{grid_ref: {0, 4}, walkable: false},
        5 => %GameTile{grid_ref: {0, 5}, walkable: false},
        6 => %GameTile{grid_ref: {0, 6}, walkable: false},
        7 => %GameTile{grid_ref: {0, 7}, walkable: false},
        8 => %GameTile{grid_ref: {0, 8}, walkable: false},
        9 => %GameTile{grid_ref: {0, 9}, walkable: false}
      },
      1 => %{
        0 => %GameTile{grid_ref: {1, 0}, walkable: false},
        1 => %GameTile{grid_ref: {1, 1}, walkable: true},
        2 => %GameTile{grid_ref: {1, 2}, walkable: true},
        3 => %GameTile{grid_ref: {1, 3}, walkable: false},
        4 => %GameTile{grid_ref: {1, 4}, walkable: false},
        5 => %GameTile{grid_ref: {1, 5}, walkable: true},
        6 => %GameTile{grid_ref: {1, 6}, walkable: true},
        7 => %GameTile{grid_ref: {1, 7}, walkable: true},
        8 => %GameTile{grid_ref: {1, 8}, walkable: true},
        9 => %GameTile{grid_ref: {1, 9}, walkable: false}
      },
      2 => %{
        0 => %GameTile{grid_ref: {2, 0}, walkable: false},
        1 => %GameTile{grid_ref: {2, 1}, walkable: true},
        2 => %GameTile{grid_ref: {2, 2}, walkable: true},
        3 => %GameTile{grid_ref: {2, 3}, walkable: true},
        4 => %GameTile{grid_ref: {2, 4}, walkable: true},
        5 => %GameTile{grid_ref: {2, 5}, walkable: true},
        6 => %GameTile{grid_ref: {2, 6}, walkable: true},
        7 => %GameTile{grid_ref: {2, 7}, walkable: false},
        8 => %GameTile{grid_ref: {2, 8}, walkable: true},
        9 => %GameTile{grid_ref: {2, 9}, walkable: false}
      },
      3 => %{
        0 => %GameTile{grid_ref: {3, 0}, walkable: false},
        1 => %GameTile{grid_ref: {3, 1}, walkable: false},
        2 => %GameTile{grid_ref: {3, 2}, walkable: true},
        3 => %GameTile{grid_ref: {3, 3}, walkable: true},
        4 => %GameTile{grid_ref: {3, 4}, walkable: false},
        5 => %GameTile{grid_ref: {3, 5}, walkable: true},
        6 => %GameTile{grid_ref: {3, 6}, walkable: true},
        7 => %GameTile{grid_ref: {3, 7}, walkable: true},
        8 => %GameTile{grid_ref: {3, 8}, walkable: true},
        9 => %GameTile{grid_ref: {3, 9}, walkable: false}
      },
      4 => %{
        0 => %GameTile{grid_ref: {4, 0}, walkable: false},
        1 => %GameTile{grid_ref: {4, 1}, walkable: true},
        2 => %GameTile{grid_ref: {4, 2}, walkable: true},
        3 => %GameTile{grid_ref: {4, 3}, walkable: true},
        4 => %GameTile{grid_ref: {4, 4}, walkable: true},
        5 => %GameTile{grid_ref: {4, 5}, walkable: true},
        6 => %GameTile{grid_ref: {4, 6}, walkable: true},
        7 => %GameTile{grid_ref: {4, 7}, walkable: true},
        8 => %GameTile{grid_ref: {4, 8}, walkable: true},
        9 => %GameTile{grid_ref: {4, 9}, walkable: false}
      },
      5 => %{
        0 => %GameTile{grid_ref: {5, 0}, walkable: false},
        1 => %GameTile{grid_ref: {5, 1}, walkable: true},
        2 => %GameTile{grid_ref: {5, 2}, walkable: true},
        3 => %GameTile{grid_ref: {5, 3}, walkable: true},
        4 => %GameTile{grid_ref: {5, 4}, walkable: true},
        5 => %GameTile{grid_ref: {5, 5}, walkable: true},
        6 => %GameTile{grid_ref: {5, 6}, walkable: true},
        7 => %GameTile{grid_ref: {5, 7}, walkable: true},
        8 => %GameTile{grid_ref: {5, 8}, walkable: true},
        9 => %GameTile{grid_ref: {5, 9}, walkable: false}
      },
      6 => %{
        0 => %GameTile{grid_ref: {6, 0}, walkable: false},
        1 => %GameTile{grid_ref: {6, 1}, walkable: true},
        2 => %GameTile{grid_ref: {6, 2}, walkable: false},
        3 => %GameTile{grid_ref: {6, 3}, walkable: false},
        4 => %GameTile{grid_ref: {6, 4}, walkable: true},
        5 => %GameTile{grid_ref: {6, 5}, walkable: true},
        6 => %GameTile{grid_ref: {6, 6}, walkable: true},
        7 => %GameTile{grid_ref: {6, 7}, walkable: false},
        8 => %GameTile{grid_ref: {6, 8}, walkable: false},
        9 => %GameTile{grid_ref: {6, 9}, walkable: false}
      },
      7 => %{
        0 => %GameTile{grid_ref: {7, 0}, walkable: false},
        1 => %GameTile{grid_ref: {7, 1}, walkable: true},
        2 => %GameTile{grid_ref: {7, 2}, walkable: false},
        3 => %GameTile{grid_ref: {7, 3}, walkable: true},
        4 => %GameTile{grid_ref: {7, 4}, walkable: true},
        5 => %GameTile{grid_ref: {7, 5}, walkable: true},
        6 => %GameTile{grid_ref: {7, 6}, walkable: true},
        7 => %GameTile{grid_ref: {7, 7}, walkable: true},
        8 => %GameTile{grid_ref: {7, 8}, walkable: true},
        9 => %GameTile{grid_ref: {7, 9}, walkable: false}
      },
      8 => %{
        0 => %GameTile{grid_ref: {8, 0}, walkable: false},
        1 => %GameTile{grid_ref: {8, 1}, walkable: true},
        2 => %GameTile{grid_ref: {8, 2}, walkable: true},
        3 => %GameTile{grid_ref: {8, 3}, walkable: true},
        4 => %GameTile{grid_ref: {8, 4}, walkable: true},
        5 => %GameTile{grid_ref: {8, 5}, walkable: true},
        6 => %GameTile{grid_ref: {8, 6}, walkable: true},
        7 => %GameTile{grid_ref: {8, 7}, walkable: true},
        8 => %GameTile{grid_ref: {8, 8}, walkable: true},
        9 => %GameTile{grid_ref: {8, 9}, walkable: false}
      },
      9 => %{
        0 => %GameTile{grid_ref: {9, 0}, walkable: false},
        1 => %GameTile{grid_ref: {9, 1}, walkable: false},
        2 => %GameTile{grid_ref: {9, 2}, walkable: false},
        3 => %GameTile{grid_ref: {9, 3}, walkable: false},
        4 => %GameTile{grid_ref: {9, 4}, walkable: false},
        5 => %GameTile{grid_ref: {9, 5}, walkable: false},
        6 => %GameTile{grid_ref: {9, 6}, walkable: false},
        7 => %GameTile{grid_ref: {9, 7}, walkable: false},
        8 => %GameTile{grid_ref: {9, 8}, walkable: false},
        9 => %GameTile{grid_ref: {9, 9}, walkable: false}
      }
    }
  end

  def walkable_grid_refs(arena) do
    arena
    |> game_tiles_as_flattened_list()
    |> Enum.filter(fn game_tile -> game_tile.walkable == true end)
    |> Enum.map(fn game_tile -> game_tile.grid_ref end)
  end

  def random_walkable_grid_ref(arena) do
    Enum.random(walkable_grid_refs(arena))
  end

  def game_tiles_as_flattened_list(arena) do
    arena
    |> Map.values()
    |> Enum.map(fn rows ->
      Enum.map(rows, fn {_, row} ->
        row
      end)
    end)
    |> List.flatten()
  end
end
