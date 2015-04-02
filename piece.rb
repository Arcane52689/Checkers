require_relative "board.rb"
require "Byebug"
class Piece
  UP_DIAG = [[ -1,1], [-1, -1]]
  DOWN_DIAG = [[1,1], [1,-1]]


  attr_reader :color, :diags, :board
  attr_accessor :position

  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
    board[position] = self
    color == :red ? @diags = UP_DIAG : @diags = DOWN_DIAG
    color == :red ? @symbol = '☺'.colorize(:red) : @symbol = "☺".colorize(:cyan)

  end



  def moves
    empty_diagonals + jumps
  end

  def occupied_by_enemy?(move)
    row, col = position
    new_pos = [row + move[0], col + move[1]]
    board.in_board?(new_pos) && board.occupied?(new_pos) && board[new_pos].color != color
  end


  def jumps
  #  byebug
    enemy_diags = diags.select { |move| occupied_by_enemy?(move) }
    result = []
    enemy_diags.each do |(drow,dcol)|
      row, col = position
      new_pos = [row + 2 * drow, col + 2 * dcol]
      result << new_pos if board.in_board?(new_pos) && board[new_pos].nil?
    end

    result
  end

  def empty_diagonals
    result = []
    row, col = position
    diags.each do |(drow,dcol)|
      new_pos = [row + drow, col + dcol]
      if board.in_board?(new_pos)
        result << new_pos  unless board.occupied?(new_pos)
      end
    end

    result
  end

  def move(end_pos)
    if (end_pos[0] - position[0]).abs == 2
      perform_jump(end_pos)
    else
      perform_slide(end_pos)
    end
    make_king if king_me?
  end

  def perform_slide(end_pos)
    board[position] = nil
    self.position = end_pos
    board[end_pos] = self
  end


  def perform_jump(end_pos)
    board.remove_captured(position,end_pos)
    board[position] = nil
    self.position = end_pos
    board[end_pos] = self
  end




  def king_me?
    if color == :red
      position[0] == 0
    else
      position[0] == 7
    end
  end


  def make_king
    @diags = UP_DIAG + DOWN_DIAG
    color == :red ? @symbol = '♔'.colorize(:red) : @symbol = '♔'.colorize(:cyan)
  end

  def to_s
    @symbol
  end

end
