require 'rails_helper'

RSpec.describe Game, type: :model do

  let(:word) { Word.new(:id => 1, :word => "apple") }
  let(:game) { Game.new(:id => 1, :word => word) }

  describe "validation" do
    it "returns invalid WORD_ID is not present" do
      game = Game.create(:word_id => "")
      game.valid?
      expect(game).to be_invalid
    end
    it "returns valid if WORD_ID is present" do
      game = Game.create(:word_id => 1)
      game.valid?
      expect(game).to be_valid
    end
  end

  describe ".status" do
    context "game has been created and no guesses have been made" do
      it "returns a playing symbol" do
        expect(game.status).to eq :playing
      end
    end
    context "all the letters have been guessed" do
      it "returns a won symbol" do
        create_turns(["a","p","l","e"])
        expect(game.status).to eq :won
      end
    end
    context "given a losing result" do
      it "returns a lost symbol" do
        create_turns(["b","c","d","f","g","h","i","j"])
        expect(game.status).to eq :lost
      end
    end
  end

  describe ".won?" do
    context "all turns have been correct guesses" do
      it "returns true" do
        create_turns(["a","p","l","e"])
        expect(game.won?).to eq true
      end
    end
    context "all letters have been correctly guessed with only 3 incorrect guesses" do
      it "returns true" do
        create_turns(["a","d","n","f","p","l","e"])
        expect(game.won?).to eq true
      end
    end
    context "there are lives left but only some characters guessed" do
      it "returns false" do
        create_turns(["a","d","n","f","p"])
        expect(game.won?).to eq false
      end
    end
  end

  describe ".lost?" do
    context "there are as many wrong guesses as lives" do
      it "returns true" do
        create_turns(["b","c","d","f","g","h","i","j"])
        expect(game.lost?).to eq true
      end
    end
    context "there are fewer wrong guesses than lives" do
      it "returns false" do
        create_turns(["b","c","d","f"])
        expect(game.lost?).to eq false
      end
    end
  end

  describe ".lives_left" do
    context "there are 3 wrong guesses and 8 lives total" do
      it "returns 5" do
        create_turns(["b","c","d"])
        expect(game.lives_left).to eq 5
      end
    end
    context "there are 8 wrong guesses and 8 lives total" do
      it "returns 0" do
        create_turns(["b","c","d","f","g","h","i","j"])
        expect(game.lives_left).to eq 0
      end
    end
  end

  describe ".correct_guesses" do
    context "the game is in progress and some letters are guessed" do
      it "returns array of correct guesses" do
        create_turns(["a","d","n","f","p"])
        expect(game.correct_guesses).to eq ["a","p"]
      end
    end
  end

  describe ".wrong_guesses" do
    context "the game is in progress and some letters are guessed" do
      it "returns array of wrong guesses" do
        create_turns(["a","d","n","f","p"])
        expect(game.wrong_guesses).to eq ["d","n","f"]
      end
    end
  end

  def create_turns(array)
    array.each do |letter|
      Turn.create!(:letter => letter, :game_id => game.id)
    end
  end
end
