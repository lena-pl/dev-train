require_relative 'model.rb'
require_relative 'interface.rb'

class Controller
  def initialize(model, ui)
    @model = model
    @ui = ui
  end

  def play
    @ui.welcome
    play_a_turn while @model.in_progress?
    @ui.show_result
  end

  private
  
  def play_a_turn
    @ui.show_encrypted_target
    @ui.check_state(@ui.get_guess.to_s.downcase)
    @ui.display_art
    @ui.announce_lives unless @model.won?
  end

end
