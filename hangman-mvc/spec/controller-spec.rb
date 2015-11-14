require_relative "../model.rb"
require_relative "../interface.rb"
require_relative "../controller.rb"

RSpec.describe Controller do
  let(:model) { Model.new("example") }
  let(:ui) { Interface.new(model) }
  let(:controller) { Controller.new(model, ui) }

  context "#play" do

    it "welcomes user, plays a losing turn and returns outcome" do
      allow(ui).to receive(:welcome)
      allow(controller).to receive(:play_a_turn)
      allow(model).to receive(:in_progress?).and_return(false)
      allow(ui).to receive(:show_result)
    end

  end
end
