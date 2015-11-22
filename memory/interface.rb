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
    puts "Open a box by typing its number:"
    guess = gets.chomp.to_i-1
    puts "You guessed #{guess}"
    guess
  end

  def check_guess(guess)
    case @model.submit_guess(guess)
    when :invalid_guess
      puts "Your guess must be an integer between 1-20"
      get_guess
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
end
