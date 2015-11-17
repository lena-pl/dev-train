class GamesController < ApplicationController

  def show
    @game = Game.find(params[:id])
    @word = Word.find(@game.word_id)
    @turns = Turn.where(game_id: @game.id)
    @secret_word = encrypt(@word.word, @turns)
    @status = @game.determine_status
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new

    @game.save!
    redirect_to @game
  end

  private

  def encrypt(word, turns)
    guesses = turns.map { |i| i.letter }
    word.chars.map do |character|
  		if guesses.include? character
  	    character
  		else
  			"_"
  		end
    end.join" "
  end

end
