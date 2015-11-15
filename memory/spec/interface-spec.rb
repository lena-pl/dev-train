require_relative "../model.rb"
require_relative "../interface.rb"

RSpec.describe Interface do
  let(:model) { Model.new("abcdefghij") }
  let(:ui) { Interface.new(model) }

  describe "#welcome" do

    it "welcomes the user" do
      expect(ui).to receive(:puts).with("Welcome to Memory!")
      expect(ui).to receive(:puts).with("The objective is to match up all boxes containing pairs of letters.")
      ui.welcome
    end

  end

  describe "#show_boxes" do

    it "shows boxes that haven't been removed" do
      expect(ui).to receive(:puts).with("[1] [2] [3] [4]")
      ui.show_boxes(["a", "b", "c", "d"], nil, nil)
    end

  end

  describe "#get_guess" do

    it "gets a guess from user" do
      expect(ui).to receive(:gets).and_return("1")
      ui.get_guess
    end

  end

  describe "#check_guess" do

    context "when the guess is invalid" do
      it "returns error message" do
        allow(model).to receive(:submit_guess).and_return(:invalid_guess)
        expect(ui).to receive(:puts).with("Your guess must be an integer between 1-20")
        ui.check_guess(0)
      end
    end

  end

  describe "#announce_tries_left" do

    it "puts out amount of guesses left" do
      allow(model).to receive(:guesses_left).and_return(10)
      expect(ui).to receive(:puts).with("You have 10 tries left!")
      ui.announce_tries_left
    end

  end

  describe "#show_result" do

    context "the game is won" do
      it "displays congratulatory message" do
        allow(model).to receive(:won?).and_return(true)
        expect(ui).to receive(:puts).with("Congrats, you won!")
        ui.show_result
      end
    end

    context "the game is lost" do
      it "displays sad message" do
        allow(model).to receive(:lost?).and_return(true)
        expect(ui).to receive(:puts).with("You lost. Better luck next time.")
        ui.show_result
      end
    end

  end
end
