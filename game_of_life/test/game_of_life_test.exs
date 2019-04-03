defmodule GameOfLifeTest do
  use ExUnit.Case
  doctest GameOfLife

#  test "{1}", do: assert GameOfLife.next_gen([[1]]) == [[0]]
#  test "{1,1}", do: assert GameOfLife.next_gen([[1,1]]) == [[0,0]]
#  test "{0,0,0}", do: assert GameOfLife.next_gen([[0,0,0]]) == [[0, 0, 0]]
#  test "{0,0,1}", do: assert GameOfLife.next_gen([[0,0,1]]) == [[0, 0, 0]]
#  test "{0,1,0}", do: assert GameOfLife.next_gen([[0,1,0]]) == [[0, 0, 0]]
#  test "{0,1,1}", do: assert GameOfLife.next_gen([[0,1,1]]) == [[0, 0, 0]]
#  test "{1,0,0}", do: assert GameOfLife.next_gen([[1,0,0]]) == [[0, 0, 0]]
#  test "{1,0,1}", do: assert GameOfLife.next_gen([[1,0,1]]) == [[0, 0, 0]]
#  test "{1,1,0}", do: assert GameOfLife.next_gen([[1,1,0]]) == [[0, 0, 0]]
#  test "{1,1,1}", do: assert GameOfLife.next_gen([[1,1,1]]) == [[0, 1, 0]]
#  test "{1,1,1,1}", do: assert GameOfLife.next_gen([[1,1,1,1]]) == [[0, 1, 1, 0]]
#  test "{1,1,1,0}", do: assert GameOfLife.next_gen([[1,1,1,0]]) == [[0, 1, 0, 0]]
#  test "{0,0,0,1}", do: assert GameOfLife.next_gen([[0,0,0,1]]) == [[0, 0, 0, 0]]
#  test "{1,0,1,1}", do: assert GameOfLife.next_gen([[1,0,1,1]]) == [[0, 0, 0, 0]]
#  test "{1,0,1,1, 1}", do: assert GameOfLife.next_gen([[1,0,1,1,1]]) == [[0, 0, 0,1, 0]]
#  test "{1,1,1,1, 1}", do: assert GameOfLife.next_gen([[1,1,1,1,1]]) == [[0, 1, 1,1, 0]]
#  test "{1,1,1,1, 1,1}", do: assert GameOfLife.next_gen([[1,1,1,1,1,1]]) == [[0, 1, 1,1,1, 0]]
  test "{0,1},{1,0}" do
    assert GameOfLife.next_gen([[0,1],
                                [1,0]]) == [[0,0],
                                            [0,0]]
    end

    test "3" do
    assert GameOfLife.next_gen([[0,1,1],
                               [0,1,0]]) == [[0,1,0],
                                             [0,0,0]]
    end
    test 4 do
    assert GameOfLife.next_gen([[0,1,1,0,0],
                                [0,1,0,1,0],
                                [0,1,0,0,0]]) == [[0,1,0,0,0],
                                                  [0,1,1,0,0],
                                                  [0,0,0,0,0]]
    end

  test "giving life to a cell" do
   assert GameOfLife.next_gen([[0,1,0],
                                [0,0,1],
                                [0,1,0]]) == [[0,0,0],
                                              [0,1,0],
                                             [0,0,0]]
  end

  test "overcrowding for a cell" do
    assert GameOfLife.next_gen([[0,1,0],
                                [1,1,1],
                                [0,1,0]]) == [[0,0,0],
                                              [0,0,0],
                                              [0,0,0]]
  end

end
