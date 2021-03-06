defmodule GameOfLife do
  @moduledoc """
  Documentation for GameOfLife.
  """

 @live1 [[0,1,1],
         [0,1,0]]

 @live2 [[0,1,0],
         [0,0,1],
         [0,1,0]]

 @live3 [[0,1,1,0,0],
         [0,1,0,1,0],
         [0,1,0,0,0]]

  @offset_y 10

 def sample1, do: @live1
 def sample2, do: @live2
 def sample3, do: @live3


  def interactive_gen_live(life, count_generations) do
    ExNcurses.initscr()
    ExNcurses.newwin(100, 40, 1 , 0)
    ExNcurses.noecho()
    ExNcurses.curs_set(0)
    x = gen_live(life, count_generations)
    ExNcurses.endwin()
    x
  end

  def draw_grid(y, x) do
    0..y - 1
    |> Enum.each(fn y ->
      0..x - 1
      |> Enum.each(fn x ->
        ExNcurses.mvaddstr(2, 0 , "x: #{inspect x}, y: #{inspect y}")
           ExNcurses.mvaddstr(y * 3 + @offset_y, x * 3 , " - ")
           ExNcurses.mvaddstr(y * 3 + 1 + @offset_y, x * 3, "| |")
           ExNcurses.mvaddstr(y * 3 + 2 + @offset_y, x * 3, " - ")
      end)
    end)
  end

  def draw_cell(life, y, x) do
    0..y - 1
    |> Enum.each(fn y ->
      0..x - 1
      |> Enum.each(fn x ->
        cell = life |> Enum.fetch!(y) |> Enum.fetch!(x)

        if(cell == 1) do
          ExNcurses.mvaddstr(y * 3 + 1 + @offset_y, x * 3 + 1, "*")
        end
      end)
    end)
  end

  def gen_live(life, 0) do
    next_gen(life)
  end
  def gen_live(life, count_generations) do
    ExNcurses.clear()
    draw_grid(length(life), length(Enum.fetch!(life, 0)))
    draw_cell(life, length(life), length(Enum.fetch!(life, 0)))
    ExNcurses.mvaddstr(0, 2, "#{inspect life}")
    ExNcurses.refresh()
    Process.sleep(2000)

#    IO.inspect life
    gen_live(next_gen(life), count_generations - 1)
  end

  def next_gen(life) do
    rows_count = length life
    columns_count = length Enum.fetch!(life, 0) # matrix always rectangle

    flat = List.flatten life
    0..length(flat) - 1
    |> Enum.reduce([], fn index, acc ->
#      IO.puts "index: #{index}"
       acc ++ [live_or_die(flat, index, rows_count, columns_count)]
    end)
    |> Enum.chunk_every(columns_count)
  end

  def  live_or_die(life, index, rows_count, columns_count)  do

    neighbours = neighbours(index, life,  columns_count)
    current = Enum.fetch!(life, index)
    result = apply_rules(current, neighbours)
#    IO.puts "result: #{result}"
    result
  end

  def apply_rules(current, {top, right, bottom, left})do
    count_live_neighbours = top + right + bottom + left
#    IO.puts "count_live_neighbours: #{count_live_neighbours}"
#    IO.puts "current #{current}\nneighbours:#{current}"
    cond do
      count_live_neighbours < 2 and current == 1 -> 0
      count_live_neighbours == 2 and current == 1 -> 1
      count_live_neighbours <= 2 and current == 0 -> 0
      count_live_neighbours == 3 and current == 0 -> 1
      count_live_neighbours > 3 and current == 1 -> 0

    end

  end

  def boundary_check_right(list, index, column_count) do
    if(rem(index, column_count) == column_count - 1 ) do
      0
    else
      fetch_cell(list, index + 1, column_count)
    end
  end


  def boundary_check_left(list, index, column_count) do
    if(rem(index , column_count) == 0 ) do
      0
    else
      fetch_cell(list, index - 1 , column_count)
    end
  end

  def fetch_cell(list, index, _) do
    try do
      :lists.nth(index + 1 , list)
    rescue
      _ -> 0

    end
  end

  def neighbours(index, life,  columns_count) do
#    IO.puts "#{inspect {index, life}}"

    left = life |> boundary_check_left(index, columns_count)
    right = life |> boundary_check_right(index, columns_count)
    top =  life |> fetch_cell(index  - columns_count, columns_count)
    bottom = life |> fetch_cell(index  + columns_count, columns_count)
#    IO.puts "#{inspect {top, right, bottom, left}}"
    {top, right, bottom, left}
  end


  def is_middle_live?([1,1,1], _) do
    1
  end

  def is_middle_live?([_ , _, _] , _) do
    0
  end

  def is_middle_live?([_,_], _) do
    0
  end

  def is_middle_live?([_], _) do
    0
  end

end
