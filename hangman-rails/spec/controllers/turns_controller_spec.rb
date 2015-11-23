require 'rails_helper'

RSpec.describe TurnsController, type: :controller do
  describe "POST create" do
    before do
      Word.create!(:id => 1, :word => "apple")
      Game.create!(:id => 1)
    end

    context 'after creation' do
      it 'redirects to game page' do
        post :create, game_id: 1, turn: { letter: "a" }
        expect(response.status).to eq(302)
      end
    end

    context 'saving fails' do
      it 'flashes an alert' do
        post :create, game_id: 1, turn: { letter: "1" }
        expect(flash[:alert]).to be_present
      end
    end
  end
end
