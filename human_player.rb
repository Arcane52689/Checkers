
class HumanPlayer
  attr_reader :color, :name, :board

  PROMPTS= {
    start:"Please enter the position of the piece you would like to move",
    end_pos:"Please enter the position you would like to move that piece to",
    name:"Please enter your name"
  }

  def initialize(name = nil)
    @name = name || ask_name
  end

  def set_color(color)
    @color = color
  end

  def get_board(board)
    @board = board
  end

  def ask_name
    puts PROMPTS[:name]
    gets.chomp
  end

  def ask_move(prompt)
    puts PROMPTS[prompt]
    gets.chomp.split("").map(&:to_i)
  end

end
