require "Byebug"
class ComputerPlayer


  attr_reader :board, :name, :color

  def initialize
    @name = "GIZMO500"
  end


  def set_color(color)
    @color = color
  end

  def get_board(board)
    @board = board
  end


  def ask_move(prompt)
    puts board.display
    return pick_piece if prompt == :start
    #byebug
    return pick_move if prompt == :end_pos
  end

  def pick_piece
    pieces = board.get_pieces(color)
    jumpers = pieces.select { |piece| piece.jumps.any? }
    if jumpers.any?
      @piece =jumpers.sample

    else
      @piece = pieces.select { |piece| piece.moves.any? }.sample
    end

    [@piece.position]
  end

  def pick_move
    move = @piece.jumps.any? ? [@piece.jumps.first] : [@piece.moves.sample]
  end

end
