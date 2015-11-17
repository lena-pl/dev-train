class TurnsController < ApplicationController

  def create

    @game = Game.find(params[:game_id])
    @turn = @game.turns.new(turn_params)

    if !@turn.save
      flash.alert = "That guess is invalid"
    end

    redirect_to @game
  end

  private
  def turn_params
    params[:turn].permit(:letter)
  end

end
