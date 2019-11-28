class Board
  def initialize
    @spaces = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    puts
    puts
    gen_board
    puts
    puts
  end
  def gen_board
    puts column1 = [" #{@spaces[0]} | #{@spaces[1]} | #{@spaces[2]} "] 
    puts rows = "-----------"
    puts column2 = [" #{@spaces[3]} | #{@spaces[4]} | #{@spaces[5]} "] 
    puts rows
    puts column3 = [" #{@spaces[6]} | #{@spaces[7]} | #{@spaces[8]} "]
  end

  def place_piece(square, piece)
    spaces[square] = piece
  end

  def space_empty?(square)
    spaces[square] == " "
  end
  
  attr_accessor :spaces
end

class Player
  def initialize(name, piece)
    @name = name
    @piece = piece
  end
end

class Game
  attr_reader :player1, :player2, :board
  def initialize
    @player1 = Player.new("Player 1", "x")
    @player2 = Player.new("Player 2", "o")
    @board = Board.new
    puts "Play by inputting games name, in this case 'game', then 'move(#)'. So game.move(1) would put your piece in the first spot. Spaces go by row, so the first space on the first row is 1, then 4 for the next row, etc."
    puts
    puts "Now... without further ado.. Player 1's turn."
    puts
    @who_just_went = ""
  end
  protected
  def who_just_went=(who_just_went)
    @who_just_went = who_just_went
  end

  public
  def move(square)
    if @who_just_went != player1
      if @board.space_empty?(square - 1)
         @board.place_piece(square - 1, "x")
         @who_just_went = player1
      else puts "That spot is already taken, please try again."
      end
    else
      if @board.space_empty?(square - 1)
        @board.place_piece(square - 1, "0")
         @who_just_went = player2
      else puts "That spot is already taken, please try again."
      end
    end
    puts
    puts
    board.gen_board
    puts
    puts
    winner
    puts
    puts
    puts
  end

  private
  def winner
    if board.spaces[0] == "x" && board.spaces[1] == "x" && board.spaces[2] == "x" || board.spaces[3] == "x" && board.spaces[4] == "x" && board.spaces[5] == "x" || board.spaces[6] == "x" && board.spaces[7] == "x" && board.spaces[8] == "x" || board.spaces[0] == "x" && board.spaces[3] == "x" && board.spaces[6] == "x" || board.spaces[1] == "x" && board.spaces[4] == "x" && board.spaces[7] == "x" || board.spaces[2] == "x" && board.spaces[5] == "x" && board.spaces[8] == "x" || board.spaces[0] == "x" && board.spaces[4] == "x" && board.spaces[8] == "x" || board.spaces[2] == "x" && board.spaces[4] == "x" && board.spaces[6] == "x"
      puts "Player 1 wins!"
      puts
      puts
      exit
    elsif board.spaces[0] == "o" && board.spaces[1] == "o" && board.spaces[2] == "o" || board.spaces[3] == "o" && board.spaces[4] == "o" && board.spaces[5] == "o" || board.spaces[6] == "o" && board.spaces[7] == "o" && board.spaces[8] == "o" || board.spaces[0] == "o" && board.spaces[3] == "o" && board.spaces[6] == "o" || board.spaces[1] == "o" && board.spaces[4] == "o" && board.spaces[7] == "o" || board.spaces[2] == "o" && board.spaces[5] == "o" && board.spaces[8] == "o" || board.spaces[0] == "o" && board.spaces[4] == "o" && board.spaces[8] == "o" || board.spaces[2] == "o" && board.spaces[4] == "o" && board.spaces[6] == "o"
      puts "Player 2 wins!"
      puts
      puts
      exit
    elsif board.spaces[0..-1].none? " "
      puts "It's a draw!"
      puts
      puts
      exit
    else
      if @who_just_went == player1
        puts
        puts "It is player 2's turn."
      else
        puts
        puts "It is player 1's turn."
      end
    end
  end
end
