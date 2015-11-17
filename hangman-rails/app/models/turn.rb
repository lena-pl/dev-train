class Turn < ActiveRecord::Base
  belongs_to :game

  before_validation :lowercase, on: :create

  validates :letter, format: { with: /\A[a-z]+\z/}
  validates :letter, length: { is: 1 }
  validates :letter, uniqueness: {scope: :game_id}

  protected

  def lowercase
    self.letter.downcase!
  end
end
