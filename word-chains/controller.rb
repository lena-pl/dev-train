require_relative 'model.rb'
require_relative 'interface.rb'

class Controller

  def initialize(model, ui)
    @model = model
    @ui = ui
  end

  def play
    @ui.welcome
    get_pair
    if @model.equal_length?(@start_word, @end_word)
      @ui.chain_message
    else
      @ui.error_message
      get_pair
    end
    @model.make_chain(@start_word, @end_word)
  end

  def get_pair
    @ui.start_word_message
    @start_word = @ui.get_word
    @ui.end_word_message
    @end_word = @ui.get_word
  end

end
