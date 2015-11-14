class Hangman

  DICTIONARY = File.read("words.txt").split
  TOTAL_LIVES = 8

  def initialize
    @target = DICTIONARY.sample.to_s
    @lives = TOTAL_LIVES
    @correct_guesses = []
    @wrong_guesses = []
  end

  def play
    play_a_turn while in_progress?
    show_result
  end

  def show_encrypted_target
    puts "Here is your word:"
    puts encrypted_word
  end

  def encrypted_word
    word = @target.chars.map do |character|
  		if @correct_guesses.include? character
  	    character
  		else
  			"_"
  		end
    end.join(" ")
    return word
  end

  def play_a_turn
    show_encrypted_target
    get_guess
    assess_lives
    check_guess
    announce_lives unless won?
  end

  def get_guess
    puts "Guess a letter"
    @guess = gets.chomp.to_s.downcase
  end

  def is_valid_character
    if is_letter? && good_length?
      true
    else
      false
    end
  end

  def is_letter?
    if @guess =~ /[[:alpha:]]/
      true
    end
  end

  def good_length?
    if @guess.length == 1
      true
    end
  end

  def check_guess
    if is_valid_character == false
      puts "Your guess must be 1 letter"
    elsif (@correct_guesses.include? @guess) || (@wrong_guesses.include? @guess)
      puts "You already guessed that letter!"
    elsif @target.include? @guess
      puts "Correct!"
      @correct_guesses.push(@guess)
    else
      puts "Wrong!"
      @wrong_guesses.push(@guess)
    end
  end

  def in_progress?
    @lives > 0 && encrypted_word.include?("_")
  end

  def assess_lives
    if is_valid_character == false
      @lives = @lives
    elsif (@correct_guesses.include? @guess) || (@wrong_guesses.include? @guess)
      @lives = @lives
    elsif (!@target.include? @guess) && !won?
      @lives -=1
    end
  end

  def announce_lives
    puts "You have #{@lives} lives left!"
    puts "=============================="
  end

  def show_result
    if won?
      print "You won! The word is '#{@target}'!"
    elsif lost?
      print "You lost! The word was '#{@target}'!"
    end
  end

  def won?
    if !encrypted_word.include?("_") && @lives > 0
      true
    end
  end

  def lost?
    if encrypted_word.include?("_") && @lives == 0
      true
    end
  end

  game = Hangman.new
  game.play

end
