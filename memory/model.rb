class Model
  attr_accessor :guess_one
  attr_accessor :guess_two
  attr_accessor :boxes
  attr_reader :guesses_left

  TOTAL_TURNS = 40

  def initialize(letters)
    @letters = letters
    @attempted_guesses = []
    @boxes = []
  end

  def create_boxes(letters)
    boxes = (letters + letters).chars.shuffle
  end

  def submit_guess(guess)
    if !valid_guess?(guess)
      :invalid_guess
    else
      @attempted_guesses.push(guess)
    end
  end

  def guesses_left
    TOTAL_TURNS - @attempted_guesses.length
  end

  def handle_match(guess_one, guess_two)
    if matching_set?(guess_one, guess_two)
      remove_pair(guess_one, guess_two)
    end
  end

  def matching_set?(guess_one, guess_two)
    boxes[guess_one] == boxes[guess_two]
  end

  def remove_pair(guess_one, guess_two)
    boxes.delete_at(guess_one)
    boxes.delete_at(guess_two)
  end

  def in_progress?
    !won? && !lost?
  end

  def won?
    false
  end

  def lost?
    guesses_left == 0
  end

  def valid_guess?(guess)
      is_integer?(guess) && in_range?(guess)
  end

  def is_integer?(guess)
    guess.is_a? Integer
  end

  def in_range?(guess)
    guess >= 1 && guess <=20
  end

end
