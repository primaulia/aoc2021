require_relative '../helpers/trim'
require 'pry-byebug'
require 'matrix'

def split_map_to_int(arr, splitter)
  arr.split(splitter).map(&:to_i)
end

def bingo(sequences,boards)
  sequence_arr = split_map_to_int(sequences, ',')
  boards_arr = split_map_to_int(boards, "\s").each_slice(25).to_a
  winning_boards = []

  matrix_width = 5
  board_index = 0
  
  current_sequence = sequence_arr[0...matrix_width]
  current_board = boards_arr[board_index]
  total_boards = boards_arr.length

  until boards_arr.empty?
    if check?(current_sequence, current_board)
      winning_boards << {
        board: current_board,
        score: score(current_sequence, current_board)
      }
      boards_arr.delete_at(board_index % boards_arr.length)
      break if boards_arr.empty?
    end

    board_index += 1
    matrix_width += 1 if board_index % boards_arr.length == 0

    current_sequence = sequence_arr[0..matrix_width]
    current_board = boards_arr[board_index % boards_arr.length]
  end

  winning_boards  
end

def transpose(array)
  matrix = Matrix[*array.each_slice(5).to_a].transpose
  matrix.to_a.flatten
end

def check?(sequences, board)
  transposed_board = transpose(board)
  sequential_row = board.each_slice(5).to_a.any? { |row| (sequences - row).length == sequences.length - 5 }
  sequential_column = transposed_board.each_slice(5).to_a.any? { |col| (sequences - col).length == sequences.length - 5 }
  sequential_row || sequential_column
end

def score(marked_numbers, board)
  (board - marked_numbers).sum * marked_numbers.last
end

