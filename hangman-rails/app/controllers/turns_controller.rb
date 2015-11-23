class TurnsController < ApplicationController

  def create

    @game = Game.find(params[:game_id])
    @turn = @game.turns.new(turn_params)

    if !@turn.save
      flash.alert = @turn.errors.messages[:letter].first
    end

    redirect_to @game
  end

  private
  def turn_params
    params.require(:turn).permit(:letter)
  end

end
