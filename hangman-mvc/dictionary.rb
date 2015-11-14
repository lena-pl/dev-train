class Dictionary

  def self.random_word
    File.read("words.txt").split.sample.to_s
  end

end
