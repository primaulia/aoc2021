require_relative '../helpers/trim'
require 'pry-byebug'
require 'matrix'

def split_map_to_int(arr, splitter)
  arr.split(splitter).map(&:to_i)
end

def bingo_win_first(sequence,boards)
  sequence_arr = split_map_to_int(sequence, ',')
  boards_arr = split_map_to_int(boards, "\s").each_slice(25).to_a
  matrix_width = 5
  board_index = 0
  
  current_sequence = sequence_arr[0...matrix_width]
  current_board = boards_arr[board_index]
  total_boards = boards_arr.length

  until bingo?(current_sequence, current_board)
    board_index += 1
    matrix_width += 1 if board_index % boards_arr.length == 0
    
    current_sequence = sequence_arr[0..matrix_width]
    current_board = boards_arr[board_index % boards_arr.length]
  end

  score(current_sequence, current_board)
end

def bingo_win_last(sequence,boards)
  sequence_arr = split_map_to_int(sequence, ',')
  boards_arr = split_map_to_int(boards, "\s").each_slice(25).to_a
  matrix_width = 5
  board_index = 0

  current_sequence = sequence_arr[0...matrix_width]
  current_board = boards_arr[board_index]

  until boards_arr.length == 1
    boards_arr.delete_at(board_index % boards_arr.length) if bingo?(current_sequence, current_board)
    
    matrix_width += 1 if board_index % boards_arr.length == 0
    board_index += 1
    current_sequence = sequence_arr[0..matrix_width]
    current_board = boards_arr[board_index % boards_arr.length]
  end

  score(current_sequence, current_board)
end

def transpose(array)
  matrix = Matrix[*array.each_slice(5).to_a].transpose
  matrix.to_a.flatten
end

def bingo?(sequences, board)
  transposed_board = transpose(board)
  sequential_row = board.each_slice(5).to_a.any? { |row| (sequences - row).length == sequences.length - 5 }
  sequential_column = transposed_board.each_slice(5).to_a.any? { |col| (sequences - col).length == sequences.length - 5 }
  sequential_row || sequential_column
end

def score(marked_numbers, winning_board)
  (winning_board - marked_numbers).sum * marked_numbers.last
end

