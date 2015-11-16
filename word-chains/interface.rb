require_relative 'model.rb'

class Interface

  def initialize(model)
    @model = model
  end

  def welcome
    puts "Welcome to word chains! Give us two words to get started."
  end

  def start_word_message
    puts "Set your start word"
  end

  def end_word_message
    puts "Set your end word"
  end

  def chain_message
    puts "Here is your chain:"
  end

  def error_message
    puts "Your 2 words have to be of equal length!"
  end

  def get_word
    gets.chomp.to_s
  end

end
