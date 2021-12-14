require_relative '../helpers/trim'
require 'pry-byebug'

def process(input)
  output = trim(input).map do |pair|
    pair = pair.split(' -> ').reduce({
      x: [],
      y: []
    }) do |accu, value|
      accu[:x] << value.split(",").map(&:to_i).first
      accu[:y] << value.split(",").map(&:to_i).last
      accu
    end
  end
end

def filter_lines(array)
  filtered_arr = array.select do |coordinate|
    horizontal?(coordinate) || vertical?(coordinate) || diagonal?(coordinate)
  end

  filtered_arr
end

def count_overlaps(coordinates)
  max_size = calc_area(coordinates)
  map = Array.new(max_size) { |i| Array.new(max_size) { |i| 0 } }
  filled_maps = fill_cells(coordinates, map)
  filled_maps.reduce(0) do |accu, row|
    accu += row.select { |cell| cell > 1 }.count
  end
end

def calc_area(coordinates)
  area = coordinates.reduce(0) do |current_size, hash|
    max_in_pair = [hash[:x].max, hash[:y].max].max
    [current_size, max_in_pair].max
  end
  area + 1
end

def fill_cells(coordinates_arr, array)
  coordinates_arr.each do |coordinate|
    if diagonal?(coordinate)
      array = fill_diagonal(coordinate, array)
    elsif horizontal?(coordinate)
      array = fill_row(coordinate, array) 
    else
      array = fill_column(coordinate, array)
    end
  end
  
  array 
end

def fill_row(coordinate, array)
  xes = coordinate[:x]
  yes = coordinate[:y]
  min_x, max_x = xes.minmax

  row = array[yes.first]
  row.each_with_index do |cell, index|
    row[index] += 1 if (min_x..max_x).include? index
  end

  array
end

def fill_column(coordinate, array)
  xes = coordinate[:x]
  yes = coordinate[:y]
  min_y, max_y = yes.minmax
  
  array.each_with_index do |row, index|
    row[xes.first] += 1 if (min_y..max_y).include? index
  end
end

def fill_diagonal(coordinate, array)
  x1, x2 = coordinate[:x]
  y1, y2 = coordinate[:y]
  
  original = [x1, y1]
  current = [x1, y1]
  destination = [x2, y2]
  
  until current == destination
    current_x, current_y = current
    destination_x, destination_y = destination

    array[current_x][current_y] += 1

    next_x = current_x < destination_x ? current_x + 1 : current_x - 1
    next_y = current_y < destination_y ? current_y + 1 : current_y - 1

    current = [next_x, next_y]
  end

  array[x2][y2] += 1
  array  
end

def horizontal?(coordinate)
  coordinate[:y].first == coordinate[:y].last
end

def vertical?(coordinate)
  coordinate[:x].first == coordinate[:x].last
end

def diagonal?(coordinate)  
  x1, x2 = coordinate[:x]
  y1, y2 = coordinate[:y].minmax
  (x1 - x2).abs == (y1 - y2).abs
end

def vents(input)
  coordinates = filter_lines(process(input))
  count_overlaps(coordinates)
end