class Model

  def initialize(dictionary)
    @dictionary = dictionary
  end

  def make_chain(start_word, end_word)
    a = start_word.chars
    b = end_word.chars

    comparison = a.zip(b).map { |x, y| x == y }
    new_word = start_word.chars

    while comparison.include? false do

      comparison.map!.with_index do |i, index|
        if i == false
          new_word[index] = b[index]
          if !is_word?(new_word.join)
            new_word[index] = a[index]
            index +=1
          end
        end
      puts new_word.join
      end

    end
    puts end_word
  end

  def is_word?(submission)
    @dictionary.include?(submission)
  end

  def equal_length?(start_word, end_word)
    start_word.length == end_word.length
  end

end
