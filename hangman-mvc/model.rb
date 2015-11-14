class Model
  attr_reader :target
  attr_reader :wrong_guesses

  TOTAL_LIVES = 8

  def initialize(target)
    @target = target
    @correct_guesses = []
    @wrong_guesses = []
  end

  def submit_guess(letter)
    if !valid_character?(letter)
      :invalid_character
    elsif already_guessed?(letter)
      :already_guessed
    elsif target.include? letter
      @correct_guesses.push(letter)
      :correct
    else
      @wrong_guesses.push(letter)
      :wrong
    end
  end

  def encrypted_word_array
    word = @target.chars.map do |character|
  		if @correct_guesses.include? character
  	    character
  		else
  			nil
  		end
    end
  end

  def lives_left
    TOTAL_LIVES - @wrong_guesses.length
  end

  def won?
    !encrypted_word_array.include?(nil) && lives_left > 0
  end

  def lost?
    encrypted_word_array.include?(nil) && lives_left == 0
  end

  def in_progress?
    !won? && !lost?
  end

  private

  def valid_character?(guess)
    is_letter?(guess) && good_length?(guess)
  end

  def already_guessed?(guess)
    @correct_guesses.include?(guess) || @wrong_guesses.include?(guess)
  end

  def is_letter?(guess)
    guess.match(/[[:alpha:]]/) != nil
  end

  def good_length?(guess)
    guess.length == 1
  end
end
