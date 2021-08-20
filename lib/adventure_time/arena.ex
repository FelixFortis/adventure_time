defmodule AdventureTime.Arena do
  alias AdventureTime.GridSquare

  def grid do
    [
      [
        %GridSquare{grid_ref: {0, 0}, walkable: false},
        %GridSquare{grid_ref: {0, 1}, walkable: false},
        %GridSquare{grid_ref: {0, 2}, walkable: false},
        %GridSquare{grid_ref: {0, 3}, walkable: false},
        %GridSquare{grid_ref: {0, 4}, walkable: false},
        %GridSquare{grid_ref: {0, 5}, walkable: false},
        %GridSquare{grid_ref: {0, 6}, walkable: false},
        %GridSquare{grid_ref: {0, 7}, walkable: false},
        %GridSquare{grid_ref: {0, 8}, walkable: false},
        %GridSquare{grid_ref: {0, 9}, walkable: false}
      ],
      [
        %GridSquare{grid_ref: {1, 0}, walkable: false},
        %GridSquare{grid_ref: {1, 1}, walkable: true},
        %GridSquare{grid_ref: {1, 2}, walkable: true},
        %GridSquare{grid_ref: {1, 3}, walkable: false},
        %GridSquare{grid_ref: {1, 4}, walkable: false},
        %GridSquare{grid_ref: {1, 5}, walkable: true},
        %GridSquare{grid_ref: {1, 6}, walkable: true},
        %GridSquare{grid_ref: {1, 7}, walkable: true},
        %GridSquare{grid_ref: {1, 8}, walkable: true},
        %GridSquare{grid_ref: {1, 9}, walkable: false}
      ],
      [
        %GridSquare{grid_ref: {2, 0}, walkable: false},
        %GridSquare{grid_ref: {2, 1}, walkable: true},
        %GridSquare{grid_ref: {2, 2}, walkable: true},
        %GridSquare{grid_ref: {2, 3}, walkable: true},
        %GridSquare{grid_ref: {2, 4}, walkable: true},
        %GridSquare{grid_ref: {2, 5}, walkable: true},
        %GridSquare{grid_ref: {2, 6}, walkable: true},
        %GridSquare{grid_ref: {2, 7}, walkable: false},
        %GridSquare{grid_ref: {2, 8}, walkable: true},
        %GridSquare{grid_ref: {2, 9}, walkable: false}
      ],
      [
        %GridSquare{grid_ref: {3, 0}, walkable: false},
        %GridSquare{grid_ref: {3, 1}, walkable: false},
        %GridSquare{grid_ref: {3, 2}, walkable: true},
        %GridSquare{grid_ref: {3, 3}, walkable: true},
        %GridSquare{grid_ref: {3, 4}, walkable: false},
        %GridSquare{grid_ref: {3, 5}, walkable: true},
        %GridSquare{grid_ref: {3, 6}, walkable: true},
        %GridSquare{grid_ref: {3, 7}, walkable: true},
        %GridSquare{grid_ref: {3, 8}, walkable: true},
        %GridSquare{grid_ref: {3, 9}, walkable: false}
      ],
      [
        %GridSquare{grid_ref: {4, 0}, walkable: false},
        %GridSquare{grid_ref: {4, 1}, walkable: true},
        %GridSquare{grid_ref: {4, 2}, walkable: true},
        %GridSquare{grid_ref: {4, 3}, walkable: true},
        %GridSquare{grid_ref: {4, 4}, walkable: true},
        %GridSquare{grid_ref: {4, 5}, walkable: true},
        %GridSquare{grid_ref: {4, 6}, walkable: true},
        %GridSquare{grid_ref: {4, 7}, walkable: true},
        %GridSquare{grid_ref: {4, 8}, walkable: true},
        %GridSquare{grid_ref: {4, 9}, walkable: false}
      ],
      [
        %GridSquare{grid_ref: {5, 0}, walkable: false},
        %GridSquare{grid_ref: {5, 1}, walkable: true},
        %GridSquare{grid_ref: {5, 2}, walkable: true},
        %GridSquare{grid_ref: {5, 3}, walkable: true},
        %GridSquare{grid_ref: {5, 4}, walkable: true},
        %GridSquare{grid_ref: {5, 5}, walkable: true},
        %GridSquare{grid_ref: {5, 6}, walkable: true},
        %GridSquare{grid_ref: {5, 7}, walkable: true},
        %GridSquare{grid_ref: {5, 8}, walkable: true},
        %GridSquare{grid_ref: {5, 9}, walkable: false}
      ],
      [
        %GridSquare{grid_ref: {6, 0}, walkable: false},
        %GridSquare{grid_ref: {6, 1}, walkable: true},
        %GridSquare{grid_ref: {6, 2}, walkable: false},
        %GridSquare{grid_ref: {6, 3}, walkable: false},
        %GridSquare{grid_ref: {6, 4}, walkable: true},
        %GridSquare{grid_ref: {6, 5}, walkable: true},
        %GridSquare{grid_ref: {6, 6}, walkable: true},
        %GridSquare{grid_ref: {6, 7}, walkable: false},
        %GridSquare{grid_ref: {6, 8}, walkable: false},
        %GridSquare{grid_ref: {6, 9}, walkable: false}
      ],
      [
        %GridSquare{grid_ref: {7, 0}, walkable: false},
        %GridSquare{grid_ref: {7, 1}, walkable: true},
        %GridSquare{grid_ref: {7, 2}, walkable: false},
        %GridSquare{grid_ref: {7, 3}, walkable: true},
        %GridSquare{grid_ref: {7, 4}, walkable: true},
        %GridSquare{grid_ref: {7, 5}, walkable: true},
        %GridSquare{grid_ref: {7, 6}, walkable: true},
        %GridSquare{grid_ref: {7, 7}, walkable: true},
        %GridSquare{grid_ref: {7, 8}, walkable: true},
        %GridSquare{grid_ref: {7, 9}, walkable: false}
      ],
      [
        %GridSquare{grid_ref: {8, 0}, walkable: false},
        %GridSquare{grid_ref: {8, 1}, walkable: true},
        %GridSquare{grid_ref: {8, 2}, walkable: true},
        %GridSquare{grid_ref: {8, 3}, walkable: true},
        %GridSquare{grid_ref: {8, 4}, walkable: true},
        %GridSquare{grid_ref: {8, 5}, walkable: true},
        %GridSquare{grid_ref: {8, 6}, walkable: true},
        %GridSquare{grid_ref: {8, 7}, walkable: true},
        %GridSquare{grid_ref: {8, 8}, walkable: true},
        %GridSquare{grid_ref: {8, 9}, walkable: false}
      ],
      [
        %GridSquare{grid_ref: {9, 0}, walkable: false},
        %GridSquare{grid_ref: {9, 1}, walkable: false},
        %GridSquare{grid_ref: {9, 2}, walkable: false},
        %GridSquare{grid_ref: {9, 3}, walkable: false},
        %GridSquare{grid_ref: {9, 4}, walkable: false},
        %GridSquare{grid_ref: {9, 5}, walkable: false},
        %GridSquare{grid_ref: {9, 6}, walkable: false},
        %GridSquare{grid_ref: {9, 7}, walkable: false},
        %GridSquare{grid_ref: {9, 8}, walkable: false},
        %GridSquare{grid_ref: {9, 9}, walkable: false}
      ]
    ]
  end

  def walkable_grid_squares do
    grid()
    |> List.flatten()
    |> Enum.filter(fn grid_square -> grid_square.walkable == true end)
    |> Enum.map(fn grid_square -> grid_square.grid_ref end)
  end

  def random_walkable_grid_square do
    Enum.random(walkable_grid_squares())
  end
end
