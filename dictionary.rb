class Dictionary
  attr_reader :filepath
  
  def initialize(filepath)
    @filepath = filepath
  end

  def exists?(lookup)
    File.foreach(filepath) do |word| 
      return true if word.chomp == lookup.downcase
    end 
  end

  def word_lookup(word)
    if exists?(word)
      "#{word} is a known word."
    else
      "#{word} is not a known word."
    end 
  end
end