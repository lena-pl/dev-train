require_relative "../model.rb"

RSpec.describe Model do
  let(:model) { Model.new("abcdefghij") }
  describe "#create_boxes" do

    it "creates an array of pairs of passed in letters" do
      expect(model.create_boxes("abcdefghij").length).to eq(("abcdefghij".length)*2)
    end

  end

  describe "#submit_guess" do

    it "decrements 1 life after a turn" do
      model.submit_guess(1)
      expect(model.guesses_left).to eq(39)
    end

    it "lets user know if their guess is out of range" do
      model.submit_guess(21)
      expect(model.valid_guess?(21)).to eq(false)
    end

    it "lets user know if their guess is not an integer" do
      model.submit_guess("a")
      expect(model.valid_guess?("a")).to eq(false)
    end

  end

  describe "#matching_set?" do

    it "returns true if two guesses are equal" do
      allow(model).to receive(:boxes).and_return(["a","a","b"])
      allow(model).to receive(:guess_one).and_return(0)
      allow(model).to receive(:guess_two).and_return(1)
      expect(model.matching_set?).to eq(true)
    end

    it "returns false if two guesses aren't equal" do
      allow(model).to receive(:boxes).and_return(["a","a","b"])
      allow(model).to receive(:guess_one).and_return(1)
      allow(model).to receive(:guess_two).and_return(2)
      expect(model.matching_set?).to eq(false)
    end

  end

  describe "#remove_pair" do

    it "removes a successfully guessed pair" do
      allow(model).to receive(:boxes).and_return(["a","a","b","b"])
      allow(model).to receive(:guess_one).and_return(0)
      allow(model).to receive(:guess_two).and_return(1)
      model.remove_pair
      expect(model.boxes.include? :boxes["a"]).to eq(false)
    end

  end

  describe "#handle_match" do

    it "removes a pair if matching" do
      allow(model).to receive(:boxes).and_return(["a","a","b"])
      allow(model).to receive(:guess_one).and_return(0)
      allow(model).to receive(:guess_two).and_return(1)
      model.handle_match
    end

  end

  describe "#in_progress?" do

    context "the game is won" do

      it "returns false when won" do
        allow(model).to receive(:won?).and_return(true)
        allow(model).to receive(:lost?).and_return(false)
        expect(model.in_progress?).to eq(false)
      end

    end

    context "the game is lost" do

      it "returns false when lost" do
        allow(model).to receive(:lost?).and_return(true)
        allow(model).to receive(:won?).and_return(false)
        expect(model.in_progress?).to eq(false)
      end

      it "returns lost when no turns left" do
        allow(model).to receive(:guesses_left).and_return(0)
        expect(model.lost?).to eq(true)
      end

    end

    it "returns true when not won or lost" do
      allow(model).to receive(:won?).and_return(false)
      allow(model).to receive(:lost?).and_return(false)
      expect(model.in_progress?).to eq(true)
    end

  end
end
