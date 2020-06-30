class HangmanGame
  attr_accessor :incomplete_guess, :word_letters, :incorrect_guesses_left, :wrong_guesses

  def initialize
    dictionary = File.open("5desk.txt")
    @word = dictionary.read.split.select {|line| line.length > 5 && line.length < 12}.sample
    @word_letters = word.split("")
    @incorrect_guesses_left = 5
    @incomplete_guess = Array.new(word.length)
    @wrong_guesses = []
  end

  def show_current_guess
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

  def make_guess(letter_guess)
    if wrong_guesses.include? letter_guess || incomplete_guess.include? letter_guess
      return "You have already tried this letter."
    end

    if word.include? letter_guess
      letter_arr = word.split("")
      indices = letter_arr.each_index.select do |i| 
        letter_arr[i] == letter_guess
      end
      indices.each do |index|
        incomplete_guess[index] = letter_guess
      end
      puts "Congratulations! You have guessed right"
    else
      incorrect_guesses_left -= 1
      wrong_guesses.push(letter_guess)
      puts "Your guess is wrong. Tries left: #{incorrect_guesses_left}"
    end
  end

  protected
  def word
    @word
  end
end

a = HangmanGame.new
puts a.incomplete_guess