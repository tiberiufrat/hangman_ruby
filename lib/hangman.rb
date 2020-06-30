require "colorize"
require "yaml"

class HangmanGame
  attr_accessor :incomplete_guess, :incorrect_guesses_left, :wrong_guesses

  @@save_names = []

  def initialize
    dictionary = File.open("5desk.txt")
    @word = dictionary.read.split.select {|line| line.length > 5 && line.length < 12}.sample.downcase
    @incorrect_guesses_left = 10
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
    if wrong_guesses.include?(letter_guess) || incomplete_guess.include?(letter_guess)
      return false
    end

    if word.include? letter_guess
      indices = word.split("").each_index.select do |i| 
        word.split("")[i] == letter_guess
      end
      indices.each do |index|
        incomplete_guess[index] = letter_guess
      end
      return 1

    else
      @incorrect_guesses_left -= 1
      wrong_guesses.push(letter_guess)
      return 0
    end
  end

  def play_round
    puts "\n\n"
    puts show_current_guess
    puts "Input letter >>".italic
    letter_guess = gets.chomp.downcase
    response = make_guess(letter_guess)

    case response
    when false
      puts "You have already tried this letter before".red
    when 0
      puts "Your guess was wrong. Try again".red
      puts "Guesses left: #{incorrect_guesses_left}".white.on_red
    when 1
      puts "Your guess was correct!".green
    end

    puts "Do you want to save this game?".italic
    answer = gets.chomp.downcase
    if answer == "yes"
      puts "Enter name for saving >>".italic
      filename = "#{gets.chomp}.yaml"
      save_to_yaml(filename)
    end
  end

  def play_game
    puts "Do you want to load a saved game? >>".italic
    load_now = gets.chomp.downcase
    if load_now == "yes"
      puts "Insert save name >>".italic
      filename = "#{gets.chomp}.yaml"
      load_from_yaml(filename)
    else
      puts "Playing new game...".bold.white.on_black
    end
    while incorrect_guesses_left > 0
      play_round()

      if self.is_won?
        puts "Congratulations! You have won the game!".white.on_green
        return 0
      end
    end
    puts "You have lost.".white.on_red
    puts "The word was:" + "#{word}".bold
  end

  def save_to_yaml(filename)
    dump = YAML.dump ({
      word: @word,
      wrong_guesses: @wrong_guesses,
      incomplete_guess: @incomplete_guess,
      incorrect_guesses_left: @incorrect_guesses_left,
    })
    File.open(filename, 'w') do |file|
      file.puts dump
    end
  end

  def load_from_yaml(filename)
    data = YAML.load File.read(filename)
    @word = data[:word]
    @wrong_guesses = data[:wrong_guesses]
    @incomplete_guess = data[:incomplete_guess]
    @incorrect_guesses_left = data[:incorrect_guesses_left]
  end

  protected
  def word
    @word
  end

  def is_won?
    incomplete_guess.join("") == word ? true : false
  end
end

a = HangmanGame.new
a.play_game