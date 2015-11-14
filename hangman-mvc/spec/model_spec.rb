require_relative "../model.rb"

RSpec.describe Model do
  let(:model) { Model.new("example") }

  describe "#submit_guess" do

    it "returns correct when guess is valid" do
      expect(model.submit_guess("e")).to eq :correct
    end

    it "returns wrong when guess is isn't in target" do
      expect(model.submit_guess("d")).to eq :wrong
    end

    it "returns invalid character when guess is a number" do
      expect(model.submit_guess("5")).to eq :invalid_character
    end

    it "returns already guessed when the letter has been guessed" do
      model.submit_guess("g")
      expect(model.submit_guess("g")).to eq :already_guessed
    end

  end

  describe "#in_progress?" do

    it "returns true if the game is still in progress" do
      allow(model).to receive(:encrypted_word_array).and_return(["h",nil,"l","l","o"])
      allow(model).to receive(:lives_left).and_return(2)
      expect(model.in_progress?).to eq true
    end

    it "returns false if game is lost" do
      allow(model).to receive(:encrypted_word_array).and_return(["h",nil,"l","l","o"])
      allow(model).to receive(:lives_left).and_return(0)
      expect(model.in_progress?).to eq false
    end

    it "returns false if game is won" do
      allow(model).to receive(:encrypted_word_array).and_return(["h","e","l","l","o"])
      allow(model).to receive(:lives_left).and_return(2)
      expect(model.in_progress?).to eq false
    end

  end
  describe "#won?" do

    it "returns true when won" do
      allow(model).to receive(:encrypted_word_array).and_return(["e","x","a","m","p","l","e"])
      expect(model.won?).to eq true
    end

    it "returns false when not won" do
      allow(model).to receive(:encrypted_word_array).and_return(["e","x","a","m","p",nil,"e"])
      expect(model.won?).to eq false
    end

  end
  describe "#lost?" do

    it "returns true when lost" do
      allow(model).to receive(:encrypted_word).and_return(["e","x","a","m","p",nil,"e"])
      allow(model).to receive(:lives_left).and_return(0)
      expect(model.lost?).to eq true
    end

    it "returns false when not lost" do
      allow(model).to receive(:encrypted_word).and_return("e x a m p _ e")
      allow(model).to receive(:lives_left).and_return(2)
      expect(model.lost?).to eq false
    end

  end
  describe "#encrypted_word_array" do

    it "encrypts letters not yet correctly guessed" do
      add_letters(model, ["e","x","a","m","p"])
      expect(model.encrypted_word_array).to eq ["e","x","a","m","p",nil,"e"]
    end

    it "encrypts word if no correct guesses made" do
      expect(model.encrypted_word_array).to eq [nil,nil,nil,nil,nil,nil,nil]
    end

  end
  describe "#lives_left" do

    it "checks amount of lives left" do
      add_letters(model, ["b","f","h","r","t"])
      expect(model.lives_left).to eq 3
    end

  end

  def add_letters(model, letters)
    letters.each do |letter|
      model.submit_guess(letter)
    end
  end

end
