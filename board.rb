class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }

  end


  def [](pos)
    row,col = pos
    grid[row][col]
  end

  def []=(pos,new_val)
    row, col = pos
    grid[row][col] = new_val
  end

  def pieces
    grid.flatten.compact
  end

  def color_pieces(color)
    grid.flatten.compact.select { |piece| piece.color == color }
  end

  def in_board(pos)
    row, col = pos
    row.between(0,7) && col.between(0,7)
  end

  def occupied(pos)
    !self[pos].nil?
  end
  
end
