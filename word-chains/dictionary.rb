class Dictionary

  def self.make
    File.read("dictionary.txt").split
  end

end
