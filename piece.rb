UP_DIAG = [[ -1,1], [-1, 1]]
DOWN_DIAG = [[1,1], [1,-1]]


class Piece
  attr_reader :color, :diags
  attr_accessor :position

  def initialize(color, position, board)
    @color = color
    @position = position
    @board = board
    board[position] = self
    color == :red ? @diags = UP_DIAG : @diags = DOWN_DIAG
  end

  def moves
    empty_diagonals + jumps
  end

  def occupied_by_enemy?(move)
    row, col = position
    new_pos = [row + move[0], col + col[0]]
    board.occupied?(new_pos) && board[new_pos].color != color
  end


  def jumps
    enemy_diags = diags.select { |move| occupied_by_enemy(move) }
    result = []
    enemy_diags.each do |(drow,dcom)|
      row, col = position
      new_pos = [row + 2 * drow, col + 2 * col]
      result << new_pos if board.in_board?(new_pos) && board[new_pos].nil?
    end

    result
  end



  def empty_diagonals
    result = []
    row, col = position
    diags.each do |(drow,dcol)|
      new_pos = [row + drow, col + dcol]
      if board.in_board(new_pos)
        result << new_pos  unless board.occupied(pos)
      end
    end

    result
  end

  def make_king
    @diags = UP_DIAG + DOWN_DIAG
  end

  def

end
