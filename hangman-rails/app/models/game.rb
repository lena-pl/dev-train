class Game < ActiveRecord::Base

  LIVES = 8

  belongs_to :word
  has_many :turns

  before_validation :set_word, on: :create

  validates :word_id, presence: true


  def determine_status
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
    lives_left >= 0 && (correct_guesses.uniq.sort == target.uniq.sort)
  end

  def lost?
    wrong_guesses.length >= LIVES
  end

  def lives_left
    LIVES - wrong_guesses.length
  end

  def target
    Word.find(self.word_id).word.chars
  end

  def correct_guesses
    correct_guesses = turns.select { |turn| target.include?(turn.letter)}
    correct_guesses.map { |turn| turn.letter }
  end

  def wrong_guesses
    wrong_guesses = turns.select { |turn| !target.include?(turn.letter)}
    wrong_guesses.map { |turn| turn.letter }
  end

  protected

  def set_word
    dictionary = Word.pluck(:id)
    self.word_id ||= dictionary.sample
  end

end
