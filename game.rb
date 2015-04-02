require_relative 'board.rb'
require_relative 'piece.rb'


class Checkers

  attr_reader :player1, :player2, :board

  def initialize(player1,player2, board = Board.default_game_board)
    @player1 = player1
    @player2 = player2

    @current_player = player1
    set_colors
  end

  def set_colors
    @player1.set_color(:red)
    @player2.set_color(:blue)
  end


  def next_player
    current_player == player1 ? player2 : player1
  end

  def play


    loop do
      break if game_over?
      move = get_move
      self.current_player = next_player
    end
  end

  def game_over?
    board.get_pieces(current_player.color).none?
  end

  def get_move
    begin
      start_pos = current_player.ask_move
      piece = board[start_pos]
      p piece.moves
      end_pos = current_player.ask_move
      if (start_pos[0] - end_pos[0]).abs == 2
        perform_jump(start_pos, end_pos)
      else
        board.move(start_pos,end_pos)
      end
    rescue StandardError => e
      puts e.message
      retry
    end

  end

  def perform_jump(start_pos, end_pos = nil)
    begin
      end_pos = end_pos || current_player.ask_move
      piece = board[start_pos]
      board.jump(start_pos, end_pos)
      if piece.jumps.any?
        peform_jump(end_pos) if current_player.jump_again?
      end
    rescue => e
      puts e.message
      retry
    end
  end


end
