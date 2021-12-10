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
  array.select do |coordinates|
    xes = coordinates[:x]
    yes = coordinates[:y]

    xes.first == xes.last || yes.first == yes.last
  end
end

def count_overlaps(coordinates)
  max_size = calc_area(coordinates) + 1
  map = Array.new(max_size) { |i| Array.new(max_size) { |i| 0 } }
  filled_maps = fill_cells(coordinates, map)
  filled_maps.reduce(0) do |accu, row|
    accu += row.select { |cell| cell > 1 }.count
  end
end

def calc_area(coordinates)
  coordinates.reduce(0) do |current_size, hash|
    max_in_pair = [hash[:x].max, hash[:y].max].max
    [current_size, max_in_pair].max
  end
end

def fill_cells(coordinates_arr, array)
  # pp coordinates_arr
  coordinates_arr.each do |coordinate|
    # binding.pry if coordinate[:x] == [9, 3]
    array = horizontal?(coordinate) ? fill_row(coordinate, array) : fill_column(coordinate, array)
  end

  # pp array
  puts
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

def horizontal?(coordinate)
  coordinate[:y].first == coordinate[:y].last
end

def vertical?(coordinate)
  !horizontal?
end

def vents(input)
  coordinates = filter_lines(process(input))
  count_overlaps(coordinates)
end