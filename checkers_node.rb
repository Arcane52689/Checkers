require_relative 'board.rb'



def checker_node
  attr_accessor :board


  def initialize(board, move = nil)
    @board = board
  end
