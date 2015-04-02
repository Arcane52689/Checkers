require_relative 'board.rb'
require_relative 'piece.rb'
require_relative 'Human_player.rb'


class Checkers

  attr_reader :player1, :player2, :board
  attr_accessor :current_player

  def self.test
    tom = HumanPlayer.new("Tom")
    tom2 = HumanPlayer.new("Tom2")
    Checkers.new(tom,tom2).play
  end


  def initialize(player1,player2, board = Board.default_game_board)
    @player1 = player1
    @player2 = player2
    @board = board
    @current_player = player1
    set_colors
    pass_board
  end

  def pass_board
    player1.get_board(board)
    player2.get_board(board)
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
      start_pos = current_player.ask_move(:start)
      piece = board[start_pos]
      raise "NOT YOUR PIECE" if self.current_player.color != piece.color
      p piece.moves
      end_pos = current_player.ask_move(:end_pos)
      raise "NOT VALID MOVE" unless piece.moves.include?(end_pos)
      piece.move(end_pos)
    rescue StandardError => e
      puts e.message
      retry
    end

  end



end
