require "Colorize"
require_relative "board.rb"


class Board
  RED_START = [
    [5,0],[5,2],[5,4],[5,6],
    [6,1],[6,3],[6,5],[6,7],
    [7,0],[7,2],[7,4],[7,6]
  ]

  BLUE_START = [
    [0,1],[0,3],[0,5],[0,7],
    [1,0],[1,2],[1,4],[1,6],
    [2,1],[2,3],[2,5],[2,7]
  ]



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

  def in_board?(pos)
    row, col = pos
    row.between?(0,7) && col.between?(0,7)
  end

  def occupied?(pos)
    !self[pos].nil?
  end

  def move(start_pos,end_pos)
    piece = self[start_pos]
    raise "NOT A VALID MOVE" unless piece.moves.include?(end_pos)
    piece.move(end_pos)
    if (start_pos[0] - end_pos[0]).abs == 2
      remove_jumped(start_pos,end_pos)
    end
  end

  def remove_jumped(pos1,pos2)
    row = (pos1[0]+pos2[0]) / 2
    col = (pos1[1] + pos2[1]) / 2
    self[[row,col]] = nil
  end


  def move!(start_pos,end_pos)
    self[start_pos].move(end_pos)
    puts display
    nil
  end











  def render
    grid.map { |row| render_row(row) }
  end

  def render_row(row)
    row.map do |piece|
      if piece.nil?
        " "
      else
        piece.to_s
      end
    end
  end




  def colored_background
    rendered_grid = render
    8.times do |i|
      8.times do |j|
        if (i+j).even?
          rendered_grid[i][j] = rendered_grid[i][j].on_light_white
        else
          rendered_grid[i][j] = rendered_grid[i][j].on_white
        end
      end
    end
    rendered_grid
  end

  def display
    colored_background.map(&:join).join("\n")
  end


  def place_pieces
    RED_START.each do |pos|
      Piece.new(:red, pos, self)
    end
    BLUE_START.each do |pos|
      Piece.new(:black,pos,self)
    end
  end





end
