class Game < ActiveRecord::Base
  LIVES = 8

  belongs_to :word
  has_many :turns

  before_validation :assign_random_word, on: :create

  validates :word_id, presence: true

  def status
    if in_progress?
      :playing
    elsif won?
      :won
    elsif lost?
      :lost
    end
  end

  def in_progress?
    !won? && !lost?
  end

  def won?
    !lost? && correct_guesses.uniq.sort == target_letters.uniq.sort
  end

  def lost?
    lives_left == 0
  end

  def lives_left
    LIVES - wrong_guesses.length
  end

  def correct_guesses
    correct_guesses = turns.select { |turn| target_letters.include?(turn.letter) }
    correct_guesses.map(&:letter)
  end

  def wrong_guesses
    wrong_guesses = turns.select { |turn| target_letters.exclude?(turn.letter) }
    wrong_guesses.map(&:letter)
  end

  protected

  def assign_random_word
    word_ids = Word.pluck(:id)
    self.word_id ||= word_ids.sample
  end

  def target_letters
    word.word.chars
  end
end
