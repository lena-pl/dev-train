require_relative 'model.rb'
require_relative 'art.rb'

class Interface

  def initialize(model)
    @model = model
  end

  def welcome
    puts "=============================="
    puts "WELCOME TO HANGMAN!"
    puts "You have #{@model.lives_left} lives!"
  end

  def display_art
    puts ART[@model.wrong_guesses.length]
  end

  def encrypted_target
    @model.encrypted_word_array.map do |character|
      if character == nil
        "_"
      else
        character
      end
    end.join(" ")
  end

  def show_encrypted_target
    puts "Here is your word:"
    puts encrypted_target
  end

  def get_guess
    puts "Guess a letter:"
    gets.chomp
  end

  def check_state(guess)
    case @model.submit_guess(guess)
      when :invalid_character then puts "Your guess must be 1 letter"
      when :already_guessed then puts "You already guessed this letter!"
      when :correct then puts "Correct!"
      when :wrong then puts "Wrong!"
    end
  end

  def announce_lives
    puts "You have #{@model.lives_left} lives left!"
    puts "=============================="
  end

  def show_result
    if @model.won?
      print "You won! The word is '#{@model.target}'!"
    elsif @model.lost?
      print "You lost! The word was '#{@model.target}'!"
    end
  end
end
