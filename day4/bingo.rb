require_relative '../helpers/trim'
require 'pry-byebug'
require 'matrix'

def split_map_to_int(arr, splitter)
  arr.split(splitter).map(&:to_i)
end

def bingo_check(sequence,boards)
  sequence_arr = split_map_to_int(sequence, ',')
  boards_arr = split_map_to_int(boards, "\s").each_slice(25).to_a

  sequence_set = sequence_arr[0...6].to_set

  binding.pry

end

def bingo?(sequences, set)
  set.subset? sequences
end

def score(marked_numbers, winning_board)
  winning_board.reduce(0) do |accu, num|
    if marked_numbers.include? num
      accu += 0
    else
      accu += num
    end
  end
end

