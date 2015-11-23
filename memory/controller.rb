require_relative 'model.rb'
require_relative 'interface.rb'

class Controller

  def initialize(model, ui)
    @model = model
    @ui = ui
  end

  def play
    @ui.welcome
    @model.create_boxes(@model.letters)
    play_a_turn while @model.in_progress?
    @ui.show_result
  end

  def play_a_turn
    @ui.show_boxes(@model.boxes, nil, nil)

    guess_one = @ui.get_guess
    @ui.show_boxes(@model.boxes, guess_one, nil)

    guess_two = @ui.get_guess
    @ui.show_boxes(@model.boxes, guess_one, guess_two)

    @model.handle_match(guess_one, guess_two)

    sleep(3)
    system "clear" or system "cls"
    @ui.announce_tries_left unless !@model.in_progress?
  end

  private

  def get_first_guess
    guess_one = @ui.get_guess
    @ui.show_boxes(@model.boxes, guess_one, nil)
  end

  def get_second_guess
    guess_two = @ui.get_guess
    @ui.show_boxes(@model.boxes, guess_one, guess_two)
  end
end
