require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "GET new" do
    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end

    it "assigns @game" do
      game = Game.new
      get :new
      expect(assigns(:game)).to be_a_new(Game)
    end

    it "renders the new game template" do
      get :new
      expect(response).to render_template("new")
    end
  end
  describe "GET show" do
    let(:word) { Word.create!(:id => 1, :word => "apple")}
    let(:game) { Game.create!(:id => 1, :word => word)}
    it "has a 200 status code" do
      get :show, id: game
      expect(response.status).to eq(200)
    end

    it "renders the show template" do
      get :show, id: game
      expect(response).to render_template("show")
    end
  end
  describe "POST create" do
    before do
      Word.create!(:id => 1, :word => "apple")
    end

    context 'after creation' do
      it 'redirects to show page' do
        post :create
        expect(response).to redirect_to(Game.last)
      end
    end
  end
end
