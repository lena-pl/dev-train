class Turn < ActiveRecord::Base
  belongs_to :game

  validates :letter, uniqueness: {scope: :game_id}
  validates :letter, format: { with: /\A[a-zA-Z]+\z/}
end
