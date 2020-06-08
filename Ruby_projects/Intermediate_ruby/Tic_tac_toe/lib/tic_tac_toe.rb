class Players
  attr_reader :player_1, :player_2

  def initialize
    @player_1 = "Player_1"
    @player_2 = "Player_2"
  end
end

class Symbols
  attr_reader :player_1_symbol, :player_2_symbol

  def initialize
    @player_1_symbol = "X"
    @player_2_symbol = "O"
  end
end

class Board
  attr_accessor :spot
  
  def initialize
    @spot = Array.new(9, " ")
  end

  def display_board
    puts "   |   |   "
    puts " #{spot[0]} | #{spot[1]} | #{spot[2]} "
    puts "___|___|___"
    puts "   |   |   "
    puts " #{spot[3]} | #{spot[4]} | #{spot[5]} "
    puts "___|___|___"
    puts "   |   |   "
    puts " #{spot[6]} | #{spot[7]} | #{spot[8]} "
    puts "   |   |   "
  end
end

class Game
  attr_accessor :players, :symbols, :board, :has_won
  def initialize
    @players = Players.new()
    @symbols = Symbols.new()
    @board = Board.new()
  end

  def play
    puts "Are you ready to play Tic Tac Toe? You can play by choosing a number between 1 and 9. Player 1 is \"X\" and Player 2 is \"O\"."
    whose_turn = "Player 1"
    turn_counter = 0
    next_turn = false
    while turn_counter != 9
      if whose_turn == "Player 1"
        board.display_board
        next_turn = false
        puts "It's Player 1's turn."
        player_choice = gets.chomp.to_i
        while next_turn == false
          if (1..9).include? player_choice
            if board.spot[player_choice - 1] == " "
              board.spot[player_choice - 1] = symbols.player_1_symbol
              whose_turn = "Player 2"
              turn_counter += 1
              winner
              if @has_won == true
                return "Player 1 has won!"
              end
              next_turn = true
            else
              puts "That spot is already taken. Please try again."
              board.display_board
              player_choice = gets.chomp.to_i
            end
          else 
            puts "Sorry, it looks like that wasn't a valid entry. Would you please enter a number between 1 and 9?"
            # board.display_board
            player_choice = gets.chomp.to_i
          end
        end
      else
        board.display_board
        puts "It's Player 2's turn."
        player_choice = gets.chomp.to_i
        next_turn = false
        while next_turn == false
          if (1..9).include? player_choice
            if board.spot[player_choice - 1] == " "
              board.spot[player_choice - 1] = symbols.player_2_symbol
              whose_turn = "Player 1"
              turn_counter += 1
              winner
              if @has_won == true
                return "Player 2 has won!"
              end
              next_turn = true
            else
              puts "That spot is already taken. Please try again."
              board.display_board
              player_choice = gets.chomp.to_i
            end
          else 
            puts "Sorry, it looks like that wasn't a valid entry. Would you please enter a number between 1 and 9?"
            board.display_board
            player_choice = gets.chomp.to_i
          end
        end
      end
    end
    board.display_board
    puts "It's a tie game!"
    return "It's a tie game!"
  end

  private

  def winner
    if board.spot[0] == "X" && board.spot[1] == "X" && board.spot[2] == "X" || board.spot[3] == "X" && board.spot[4] == "X" && board.spot[5] == "X" || board.spot[6] == "X" && board.spot[7] == "X" && board.spot[8] == "X" || board.spot[0] == "X" && board.spot[3] == "X" && board.spot[6] == "X" || board.spot[1] == "X" && board.spot[4] == "X" && board.spot[7] == "X" || board.spot[2] == "X" && board.spot[5] == "X" && board.spot[8] == "X" || board.spot[0] == "X" && board.spot[4] == "X" && board.spot[8] == "X" || board.spot[2] == "X" && board.spot[4] == "X" && board.spot[6] == "X"
      board.display_board
      @has_won = true
      return "Player 1 has won!"
      exit
    end
    if board.spot[0] == "O" && board.spot[1] == "O" && board.spot[2] == "O" || board.spot[3] == "O" && board.spot[4] == "O" && board.spot[5] == "O" || board.spot[6] == "O" && board.spot[7] == "O" && board.spot[8] == "O" || board.spot[0] == "O" && board.spot[3] == "O" && board.spot[6] == "O" || board.spot[1] == "O" && board.spot[4] == "O" && board.spot[7] == "O" || board.spot[2] == "O" && board.spot[5] == "O" && board.spot[8] == "O" || board.spot[0] == "O" && board.spot[4] == "O" && board.spot[8] == "O" || board.spot[2] == "O" && board.spot[4] == "O" && board.spot[6] == "O"
      board.display_board
      @has_won = true
      return "Player 2 has won!"
      exit
    end
  end
end

class Test

  def tester
    return "hi"
  end
  
end

# game = Game.new()
# game.play
