require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:word) { Word.create!(:id => 1, :word => "apple") }
  subject(:game) { Game.create!(:id => 1, :word => word) }

  describe "validation" do
    it { is_expected.to be_valid }

    context "WORD_ID is not present" do
      it "fails validation" do
        game = Game.create(:word => nil)

        expect(game).to be_invalid
      end
    end
  end

  describe "#status" do
    subject { game.status }

    context "game has been created and no guesses have been made" do
      it { is_expected.to eq :playing }
    end

    context "all the letters have been guessed" do
      before do
        create_turns(%w{a p l e})
      end

      it { is_expected.to eq :won }
    end

    context "given a losing result" do
      before do
        create_turns(%w{b c d f g h i j})
      end

      it { is_expected.to eq :lost }
    end
  end

  describe ".won?" do
    subject { game.won? }

    context "all turns have been correct guesses" do
      before do
        create_turns(%w{a p l e})
      end

      it { is_expected.to eq true }
    end

    context "all letters have been correctly guessed with only 3 incorrect guesses" do
      before do
        create_turns(%w{a d n f p l e})
      end

      it "returns true" do
        expect(game.won?).to eq true
      end
    end

    context "there are lives left but only some characters guessed" do
      before do
        create_turns(%w{a d n f p})
      end

      it "returns false" do
        expect(game.won?).to eq false
      end
    end
  end

  describe ".lost?" do
    context "there are as many wrong guesses as lives" do
      before do
        create_turns(%w{b c d f g h i j})
      end

      it "returns true" do
        expect(game.lost?).to eq true
      end
    end

    context "there are fewer wrong guesses than lives" do
      before do
        create_turns(%w{b c d f})
      end

      it "returns false" do
        expect(game.lost?).to eq false
      end
    end
  end

  describe ".lives_left" do
    context "there are 3 wrong guesses and 8 lives total" do
      before do
        create_turns(%w{b c d})
      end

      it "returns 5" do
        expect(game.lives_left).to eq 5
      end
    end

    context "there are 8 wrong guesses and 8 lives total" do
      before do
        create_turns(%w{b c d f g h i j})
      end

      it "returns 0" do
        expect(game.lives_left).to eq 0
      end
    end
  end

  context "the game is in progress and some letters are guessed" do
    before do
      create_turns(%w{a d n f p})
    end

    describe ".correct_guesses" do
      it "returns array of correct guesses" do
        expect(game.correct_guesses).to eq ["a","p"]
      end
    end

    describe ".wrong_guesses" do
      it "returns array of wrong guesses" do
        expect(game.wrong_guesses).to eq ["d","n","f"]
      end
    end
  end

  def create_turns(array)
    array.each do |letter|
      Turn.create!(:letter => letter, :game => game)
    end
  end
end
