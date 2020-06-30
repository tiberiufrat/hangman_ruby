class HangmanGame
  attr_accessor :word_letters, :incorrect_guesses_left, :wrong_guesses

  def initialize
    dictionary = File.open("5desk.txt")
    @word = dictionary.read.split.select {|line| line.length > 5 && line.length < 12}.sample
    @word_letters = word.split("")
    @incorrect_guesses_left = 5
    @incomplete_guess = Array.new(word.length)
    @wrong_guesses = []
  end

  def incomplete_guess
    guess_arr = []
    @incomplete_guess.each do |item|
      unless item.nil?
        guess_arr.push(item)
      else
        guess_arr.push("_")
      end
    end
    guess_arr.join(' ')
  end

  protected
  def word
    @word
  end
end

a = HangmanGame.new
puts a.incomplete_guess