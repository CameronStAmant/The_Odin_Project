class Setup
  attr_accessor :board1, :player1, :player2

  def initialize
    @player1 = ""
    @board1 = Array.new(6){Array.new(7," ")}
  end

  def choose_color
    puts "Choose your color player 1."
    while @player1 == ""
      @player1 = gets.chomp
      if @player1 == "x"
        @player2 = "o"
      elsif @player1 == "o"
        @player2 = "x"
      else
        puts "That is not an acceptable answer. Try again."
        @player1= ""
      end
    end
    return @player1, @player2
  end

  def display_board
    @board1.each do |i|
      print "\n"
      @draw = "|_____|_____|_____|_____|_____|_____|_____|"
      puts @draw
        i.each do |n|
            print "|  #{n}  "
        end
        print "|"
   end 
   print "\n"
   print @draw
   return @board1
  end
end

class Play

  def initialize
    @whose_turn = 0
    @game_over = false
  end

  def display_board
    @board1.each do |i|
      puts
      @draw = "|_____|_____|_____|_____|_____|_____|_____|"
      puts @draw
        i.each do |n|
            print "|  #{n}  "
        end
        print "|"
   end 
   puts
   print @draw
   puts
   return @board1
  end

  def turn(board:, player:)
    @board1 = board
    while @game_over == false
      successful_placement = false
      while successful_placement != true
        row = -1
        puts "\n Which column would you like to place a checker?"
        @column_choice = gets.chomp.to_i
        @column_choice -= 1
        reguess = false
        # p board
        display_board
        while reguess == false
          if row == -8
            puts "That column is full, try a different column."
            reguess = true
          elsif board[row][@column_choice] == " "
            board[row][@column_choice] = @whose_turn % 2 == 0 ? player.player1 : player.player2
            if winner?(board: board, player: @whose_turn % 2 == 0 ? player.player1 : player.player2) == true
              return
            end
            successful_placement = true
            @whose_turn += 1
            reguess = true
          else
            row -= 1
          end
        end
      end
    end
  end

  def winner?(board:, player:)
    #horizontal
    board.each do |row|
      row.each_cons(4) do |piece|
        if piece == ["x", "x", "x", "x"]
          puts "\n #{player} has won!"
          return true
        elsif piece == ["o", "o", "o", "o"]
          puts "\n #{player} has won!"
          return true
        end
      end
    end
    #vertical
    @a = 0
    until @a == 7
        @column = Array.new
        board.each do |element|
            @column <<  element[@a]
            @column.each_cons(4) do |piece|
              if piece == ["x","x","x","x"]
                puts "\n #{player} has won!"
                return true
              elsif piece == ["o","o","o","o"]
                puts "\n #{player} has won!"
                return true
              end  
            end
        end
        @a += 1
    end
    #diagonally right
    counter = 0
    until counter == 4
      @a = counter 
      @b = 0
      until @b == 3 
        @diagonal_array = Array.new 
        board[@b..5].each do |element|
          @diagonal_array << element[@a]
          @a +=1
          @diagonal_array.each_cons(4) do |piece|
            if piece == ["x","x","x","x"]
              puts "\n #{player} has won!"
              return true 
            elsif piece == ["o","o","o","o"]
              puts "\n #{player} has won!"
              return true
            end
          end
        end
        @a = 0
        @b +=1
      end
      counter +=1
    end

    #diagonally left
    counter = 6
    until counter == 3
      @a = counter 
      @b = 0
      until @b == 3 
        @diagonal_array = Array.new 
        board[@b..5].each do |element|
          @diagonal_array << element[@a]
          @a -=1
          @diagonal_array.each_cons(4) do |piece|
            if piece == ["x","x","x","x"]
              puts "\n #{player} has won!"
              return true
            elsif piece == ["o","o","o","o"]
              puts "\n #{player} has won!"
              return true
            end
          end
        end
        @a = 0
        @b +=1
      end
      counter -=1
    end
  end

end

class Game
  attr_reader :setup, :play
  
  def initialize
    @play = Play.new
    @setup = Setup.new
  end
end