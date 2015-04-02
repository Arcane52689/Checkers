
class HumanPlayer


  PROMPTS {
    start: "Please enter the position of the piece you would like to move",
    end_pos: "Please enter the position you would like to move that piece to"
    name: "Please enter your name"
  }

  def initialize(name = nil)
    @name = name || ask_name
  end

  def set_color(color)
    self.color = color
  end

  def ask(prompt)
    puts PROMPTS[prompt]
    gets.chomp
  end

end
