class Turn < ActiveRecord::Base
  belongs_to :game

  before_validation :lowercase, on: :create

  validates :letter, format: { with: /\A[a-z]+\z/,
    message: "%{value} is not a letter" }
  validates :letter, length: { is: 1,
    message: "Your guess must be 1 character long" }
  validates :letter, uniqueness: {scope: :game_id,
    message: "You already guessed the letter %{value}"}

  protected

  def lowercase
    self.letter.downcase!
  end
end
