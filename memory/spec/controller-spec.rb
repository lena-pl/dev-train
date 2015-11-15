require_relative "../model.rb"
require_relative "../interface.rb"
require_relative "../controller.rb"

RSpec.describe Controller do
  let(:model) { Model.new("abcdefghij") }
  let(:ui) { Interface.new(model) }
  let(:controller) { Controller.new(model, ui) }
  describe "#play" do

    context "at the start of the game" do
      it "welcomes user" do
        expect(ui).to receive(:welcome)
        allow(model).to receive(:in_progress?).and_return(false)
        controller.play
      end
    end

    context "while the game is in progress" do
      it "plays a turn" do
        allow(model).to receive(:in_progress?).and_return(true)
        allow(controller).to receive(:play_a_turn)
        allow(model).to receive(:in_progress?).and_return(false)
        controller.play
      end
    end

    context "when game is over" do
      it "shows loss/win" do
        allow(model).to receive(:in_progress?).and_return(false)
        expect(ui).to receive(:show_result)
        controller.play
      end
    end

  end

  describe "#play_a_turn" do

    it "shows letters in open boxes" do
      allow(ui).to receive(:show_boxes)
      expect(ui).to receive(:get_guess)
      expect(ui).to receive(:get_guess)
      expect(model).to receive(:handle_match)
      controller.play_a_turn
    end

  end
end
