require 'yaml'

class GameSetup
  attr_reader :total_guesses, :incorrect_guesses, :word_array, :current_turn, :guess, :secret_word, :hidden_word

  def initialize
    @total_guesses = 12
    @incorrect_guesses = []
    @current_turn = 1
    @guess = ""
    @secret_word = ""
    @word_array = []
    @hidden_word = []
  end

  def create
    File.open("5desk.txt").readlines.each do |line|
      if line.length > 5 && line.length < 14
        word_array << line
      end
    end
    @secret_word = word_array.sample[0..-2].downcase
    @hidden_word = Array.new(secret_word.length, "_")
  end
end

class Turn
  attr_reader :hidden_word
  
  def turn(total_guesses, secret_word, current_turn, incorrect_guesses, hidden_word)
    puts "You have #{total_guesses - current_turn + 1} strikes left. The word is #{secret_word.length} letters long. Enter 'save' at anytime to save your game."
    while current_turn < total_guesses + 1
      puts
      hidden_word.each { |i| print "#{i} " }
      puts
      puts
      puts "Incorrect guesses" 
      print incorrect_guesses
      puts
      puts
      guess = gets.chomp.downcase
      puts
      if guess == 'save'
        game_file = File.open("Saved_Game", "w")
        a = YAML.dump ({
          :secret_word => secret_word,
          :total_guesses => total_guesses,
          :current_turn => current_turn,
          :incorrect_guesses => incorrect_guesses,
          :hidden_word => hidden_word
        })
        game_file.puts a
        game_file.close
        puts "Your game has been saved."
      elsif guess.length > 1
        puts "That is more than one character. Try again."
        redo
      elsif guess =~ /[^a-z]/
        puts "That is not an acceptable guess. It needs to be between a and z. Try again."
        redo
      elsif incorrect_guesses.include? guess
        puts "You've already guessed that, try again."
        redo
      elsif secret_word.include? guess
        i = 0
        while i < secret_word.length
          if secret_word[i] == guess
            hidden_word[i] = guess
          end
          i += 1
        end
        if secret_word == hidden_word.join
          puts "You win! The word was #{secret_word}"
          exit
        end
      else
        incorrect_guesses << guess
        current_turn += 1
        puts "That letter is not within the word. You have #{total_guesses - current_turn + 1} strikes left "
      end
    end
    puts
    puts "Game over. The word was #{secret_word}"
    exit
  end
end

class Game
attr_reader :turn, :game

  def initialize
    @game = GameSetup.new
    @turn = Turn.new
  end

  def play
    puts "Would you like to load your saved game or start a new one? Answer 'load' or 'new'."
    a = 0
    while a != 1
      answer = gets.chomp
      if answer == 'load'
        if File.exist?('Saved_Game')
          game_file = File.open("Saved_Game", "r")
          contents = YAML.load(game_file.read)
          secret_word = contents[:secret_word]
          total_guesses = contents[:total_guesses]
          current_turn = contents[:current_turn]
          incorrect_guesses = contents[:incorrect_guesses]
          hidden_word = contents[:hidden_word]
          game_file.close
          turn.turn(total_guesses, secret_word, current_turn, incorrect_guesses, hidden_word)
        else
          puts "It looks like there aren't any saved files. In that case, let's get you started on a new game."
          sleep 2
          puts
          game.create
          turn.turn(game.total_guesses, game.secret_word, game.current_turn, game.incorrect_guesses, game.hidden_word)
        end
      elsif answer == 'new'
        game.create
        turn.turn(game.total_guesses, game.secret_word, game.current_turn, game.incorrect_guesses, game.hidden_word)
      else
        puts "It doesn't look like you answered correctly, would you please respond with 'load' or 'new'?"
      end
    end
  end
end

game = Game.new
game.play