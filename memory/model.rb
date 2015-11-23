class Model
  attr_accessor :guess_one
  attr_accessor :guess_two
  attr_accessor :boxes
  attr_reader :guesses_left
  attr_reader :letters

  TOTAL_TURNS = 40

  def initialize(letters)
    @letters = letters
    @attempted_guesses = []
    @boxes = []
  end

  def create_boxes(letters = @letters)
    @boxes = (letters + letters).chars.shuffle
  end

  def submit_guess(guess)
    if !valid_guess?(guess)
      :invalid_guess
    else
      @attempted_guesses.push(guess)
      puts "Your attempted guesses: #{@attempted_guesses.join(",")}"
    end
  end

  def guesses_left
    TOTAL_TURNS - @attempted_guesses.length
  end

  def handle_match(guess_one, guess_two)
    if matching_set?(guess_one, guess_two)
      remove_pair(guess_one)
    end
  end

  def matching_set?(guess_one, guess_two)
    boxes[guess_one] == boxes[guess_two]
  end

  def remove_pair(guess_one)
    guess = boxes[guess_one]
    boxes.map do |letter|
      if letter == guess
        boxes.delete(letter)
      end
    end
  end

  def in_progress?
    !won? && !lost?
  end

  def won?
    @boxes.empty? && !lost?
  end

  def lost?
    guesses_left <= 0
  end

  def valid_guess?(guess)
      is_numeric?(guess) && in_range?(guess) && under_box_amount?(guess)
  end

  def is_numeric?(guess)
    guess.is_a? Numeric
  end

  def in_range?(guess)
    guess.between?(0, 19)
  end

  def under_box_amount?(guess)
    @boxes.length >= guess + 1
  end
end
