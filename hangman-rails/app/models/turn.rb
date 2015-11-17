class Turn < ActiveRecord::Base
  belongs_to :game
  
  validates :letter, format: { with: /\A[a-zA-Z]+\z/}
  validates :letter, length: { is: 1 }
  validates :letter, uniqueness: {scope: :game_id}
end
