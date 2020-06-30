class HangmanGame
  attr_accessor :guess, :word_letters, :incorrect_guesses_left, :wrong_guesses

  def initialize
    dictionary = File.open("5desk.txt")
    @word = dictionary.read.split.select {|line| line.length > 5 && line.length < 12}.sample
    @word_letters = word.split("")
    @incorrect_guesses_left = 5
    @guess = Array.new(word.length)
    @wrong_guesses = []
  end

  def guess
    
  end

  protected
  def word
    @word
  end
end