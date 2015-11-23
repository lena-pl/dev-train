class Interface

  def initialize(model)
    @model = model
  end

  def welcome
    puts "Welcome to Memory!"
    puts "The objective is to match up all boxes containing pairs of letters."
  end

  def show_boxes(boxes, guess_one, guess_two)
      puts(boxes.map {|box| "[#{box}]"}.join(" "))
      puts(boxes.each_with_index.map { |box, index| index == guess_one || index == guess_two ? "[#{box}]" : "[#{index + 1}]" }.join(" "))
  end

  def get_guess
    guess_prompt
    guess = gets.chomp.to_i-1
    while check_guess(guess) != :valid
      guess_prompt
      guess = gets.chomp.to_i-1
    end
    guess
  end

  def check_guess(guess)
    case @model.submit_guess(guess)
    when :invalid_guess
      puts "Your guess must be an integer between 1-20"
    else
      :valid
    end
  end

  def announce_tries_left
      puts "You have #{@model.guesses_left} tries left!"
  end

  def show_result
    if @model.won?
      puts "Congrats, you won!"
    elsif @model.lost?
      puts "You lost. Better luck next time."
    end
  end

  def guess_prompt
    puts "Open a box by typing its number:"
  end
end
