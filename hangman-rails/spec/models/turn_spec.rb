require 'rails_helper'

RSpec.describe Turn, type: :model do
  describe "validation" do
    it "validates correctly entered LETTER" do
      turn = Turn.create(:letter => "a")
      turn.valid?

      expect(turn).to be_valid
    end

    it "only allows LETTER to be 1 character long" do
      turn = Turn.create(:letter => "aaa")
      turn.valid?

      expect(turn).to be_invalid
    end

    it "does not allow LETTER field to be a number" do
      turn = Turn.create(:letter => "1")
      turn.valid?

      expect(turn).to be_invalid
    end

    it "does not allow duplicate LETTER fields for one game" do
      Turn.create(:letter => "a", :game_id => 1)
      turn = Turn.create(:letter => "a", :game_id => 1)
      turn.valid?

      expect(turn).to be_invalid
    end
  end
end
