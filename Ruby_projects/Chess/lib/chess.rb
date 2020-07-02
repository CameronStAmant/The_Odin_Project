require_relative "board"
require_relative "pieces"
require "yaml"

class Game
  attr_reader :board, :turn, :potential_black_moves, :potential_white_moves, :black_position_locator, :white_position_locator, :landing, :black_king_check, :white_king_check, :actual_turn, :black, :white, :final, :starting, :checkmate

  def initialize
    @board = Board.new
    @pieces = Pieces.new
    @turn = "black"
    @potential_black_moves = []
    @potential_white_moves = []
    @black_position_locator = []
    @white_position_locator = []
    @landing = ""
    @black_king_check = false
    @white_king_check = false
    @actual_turn = ""
    @black = ["\u265A", "\u265B", "\u265C", "\u265D", "\u265E", "\u265F"]
    @white = ["\u2654", "\u2655", "\u2656", "\u2657", "\u2658", "\u2659"]
    @final = ""
    @starting = ""
    @checkmate = false
  end

  def move(starting = nil, ending = nil, human = nil)
    if starting == "save"
      game_file = File.open("Saved_Game", "w")
      saving = YAML.dump ({
        :board => board,
        :turn => turn
      })
      game_file.puts saving
      game_file.close
      if human == nil
        puts "Game saved!"
      end
      return "Game saved!"
    elsif starting == "load"
      if File.exist?("Saved_Game")
        game_file = File.open("Saved_Game", "r")
        contents = YAML.load(game_file.read)
        @board = contents[:board]
        @turn = contents[:turn]
        game_file.close
        if human == nil
          puts "Game loaded!"
        end
        return "Game loaded!"
      end
    else
      piece = @board.board[starting]
      if 
        (piece == @pieces.rook_black && @pieces.rook_potential_moves.include?(ending)) || 
        (piece == @pieces.knight_black && @pieces.knight_potential_moves.include?(ending)) || 
        (piece == @pieces.bishop_black && @pieces.bishop_potential_moves.include?(ending)) || 
        (piece == @pieces.queen_black && @pieces.queen_potential_moves.include?(ending)) ||
        (piece == @pieces.king_black && @pieces.king_potential_moves.include?(ending)) ||
        (piece == @pieces.pawn_black && @pieces.pawn_black_potential_moves.include?(ending)) ||
        (piece == @pieces.pawn_black && @pieces.pawn_black_potential_diagonal_moves.include?(ending)) || 

        (piece == @pieces.rook_white && @pieces.rook_potential_moves.include?(ending)) || 
        (piece == @pieces.knight_white && @pieces.knight_potential_moves.include?(ending)) || 
        (piece == @pieces.bishop_white && @pieces.bishop_potential_moves.include?(ending)) || 
        (piece == @pieces.queen_white && @pieces.queen_potential_moves.include?(ending)) ||
        (piece == @pieces.king_white && @pieces.king_potential_moves.include?(ending)) ||
        (piece == @pieces.pawn_white && @pieces.pawn_white_potential_moves.include?(ending)) ||
        (piece == @pieces.pawn_white && @pieces.pawn_white_potential_diagonal_moves.include?(ending))
        
        start = starting.split(",")
        @starting = starting
        move = ending.split(",")
        c = start[0].to_i + move[0].to_i
        d = start[1].to_i + move[1].to_i
        @final = "#{c},#{d}"
        final_split = @final.split(",")
        if (human == nil)
          if (@turn == "black") && @black_king_check == true 
            if piece != "\u265A"
              move(starting,ending,"a")
              @turn = "black"
              if check? == "Check!"
                @board.board[starting] = piece
                @board.board[@final] = " "
                if human == nil
                  puts "You must move your king!"
                end
                return "You must move your king!"
              else
                if human == nil
                  puts "Successful move."
                end
                return "Successful move."
              end
            end
          elsif (@turn == "white") && @white_king_check == true
            if piece != "\u2654"
              move(starting,ending,"a")
              @turn = "white"
              if check? == "Check!"
                @board.board[starting] = piece
                @board.board[@final] = " "
                if human == nil
                  puts "You must move your king!"
                end
                return "You must move your king!"
              else
                if human == nil
                  puts "Successful move."
                end
                return "Successful move."
              end
            end
          end
        end
        @black_king_check = false
        @white_king_check = false
  
        if @board.board.include? @final
          if (piece == @pieces.pawn_black) || (piece == @pieces.pawn_white)
            if ((@turn == "white") && (@black.include? @board.board[@final]) && (ending == "2,0" || ending == "1,0")) || ((@turn == "black") && (@white.include? @board.board[@final]) && (ending == "-2,0" || ending == "-1,0"))
              if human == nil
                puts "The pawn cannot do that action."
              end
              return "The pawn cannot do that action."
            end
            if ((ending == "-2,0") && piece == @pieces.pawn_black) || ((ending == "2,0") && piece == @pieces.pawn_white)
              if ((starting.include? "7,") && piece == @pieces.pawn_black) || ((starting.include? "2,") && piece == @pieces.pawn_white)
              else
                if piece == @pieces.pawn_black
                  if human == nil
                    puts "The black pawn can only move two on their initial move. Please choose again."
                  end
                  return "The black pawn can only move two on their initial move. Please choose again."
                else
                  if human == nil
                    puts "The white pawn can only move two on their initial move. Please choose again."
                  end
                  return "The white pawn can only move two on their initial move. Please choose again."
                end
              end
            end
          end
          if @turn == "black"
            if @black.include? @board.board[@final]
              if human == nil
                puts "You cannot move onto one of your pieces."
              end
              return "You cannot move onto one of your pieces."
            end
          elsif @turn == "white"
            if @white.include? @board.board[@final]
              if human == nil
                puts "You cannot move onto one of your pieces."
              end
              return "You cannot move onto one of your pieces."
            end
          end
          if (piece == @pieces.knight_black) || (piece == @pieces.knight_white)
            @board.board[@final] = @board.board[starting]
            @board.board[starting] = " "
            if @turn == "black"
              @turn = "white"
            else
              @turn = "black"
            end
            if (human == nil)
              check?
            end
            @landing = @final
            if human == nil
              puts "Successful move."
            end
            return "Successful move."
          else
            if (piece == @pieces.queen_black) || (piece == @pieces.queen_white)
              if (start[0] == final_split[0]) || (start[1] == final_split[1])
                queen = "vertical/horizontal"
              else
                queen = "diagonal"
              end
            end
            if (piece == @pieces.king_black) || (piece == @pieces.king_white)
              if (start[0] == final_split[0]) || (start[1] == final_split[1])
                king = "vertical/horizontal"
              else
                king = "diagonal"
              end
            end
            path = []
            all_moves = false
            step = ""
            while all_moves != true
              if (piece == @pieces.rook_black) || (piece == @pieces.rook_white) || (queen == "vertical/horizontal") || (king == "vertical/horizontal") || ((piece == @pieces.pawn_black) && @pieces.pawn_black_potential_moves.include?(ending)) || ((piece == @pieces.pawn_white) && @pieces.pawn_white_potential_moves.include?(ending))
                if start[0] != final_split[0]
                  if move[0].to_i < 0
                    step = "#{start[0].to_i - 1}, 0"
                    step_split = step.split(",")
                    start = "#{step_split[0]},#{start[1]}"
                    path << start
                    start = start.split(",")
                  else
                    step = "#{start[0].to_i + 1}, 0"
                    step_split = step.split(",")
                    start = "#{step_split[0]},#{start[1]}"
                    path << start
                    start = start.split(",")
                  end
                elsif start[1] != final_split[1]
                  if move[1].to_i < 0
                    step = "0,#{start[1].to_i - 1}"
                    step_split = step.split(",")
                    start = "#{start[0]},#{step_split[1]}"
                    path << start
                    start = start.split(",")
                  else
                    step = "0,#{start[1].to_i + 1}"
                    step_split = step.split(",")
                    start = "#{start[0]},#{step_split[1]}"
                    path << start
                    start = start.split(",")
                  end
                else
                  all_moves = true
                end
              elsif (piece == @pieces.bishop_black) || (queen == "diagonal") || (king == "diagonal") || (piece == @pieces.bishop_white) || ((piece == @pieces.pawn_black) && (@pieces.pawn_black_potential_diagonal_moves.include?(ending)) && (white.include? @board.board[@final])) || ((piece == @pieces.pawn_white) && (@pieces.pawn_white_potential_diagonal_moves.include?(ending)) && (black.include? @board.board[@final]))
                if start.join(",") != @final
                  if move[0].to_i < 0
                    step = "#{start[0].to_i - 1}, 0"
                    step_split = step.split(",")
                    start = "#{step_split[0]},#{start[1]}"
                    start = start.split(",")
                  else
                    step = "#{start[0].to_i + 1}, 0"
                    step_split = step.split(",")
                    start = "#{step_split[0]},#{start[1]}"
                    start = start.split(",")
                  end
                  if move[1].to_i < 0
                    step = "0,#{start[1].to_i - 1}"
                    step_split = step.split(",")
                    start = "#{start[0]},#{step_split[1]}"
                    path << start
                    start = start.split(",")
                  else
                    step = "0,#{start[1].to_i + 1}"
                    step_split = step.split(",")
                    start = "#{start[0]},#{step_split[1]}"
                    path << start
                    start = start.split(",")
                  end
                else
                  all_moves = true
                end
              else
                if human == nil
                  puts "Bad move"
                end
                return "Bad move."
              end
            end
          end
          path.each do |x|
            if (black.include? @board.board[x]) || (white.include? @board.board[x])
              if x == path[-1]
                @board.board[@final] = @board.board[starting]
                @board.board[starting] = " "
                if @turn == "black"
                  @turn = "white"
                else
                  @turn = "black"
                end
                if (((piece == @pieces.pawn_black) && (["1,1","1,2","1,3","1,4","1,5","1,6","1,7","1,8"].include? @final)) || ((piece == @pieces.pawn_white) && (["8,1","8,2","8,3","8,4","8,5","8,6","8,7","8,8"].include? @final)))
                  if human == nil
                    puts "What would you like to upgrade to?"
                    if piece == @pieces.pawn_black
                      until @board.board[@final] == "\u265B" || @board.board[@final] == "\u265D" || @board.board[@final] == "\u265E" || @board.board[@final] == "\u265C"
                        upgrade = STDIN.gets.chomp
                        case upgrade
                        when "queen"
                          @board.board[@final] = "\u265B"
                        when "bishop"
                          @board.board[@final] = "\u265D"
                        when "knight"
                          @board.board[@final] = "\u265E"
                        when "rook"
                          @board.board[@final] = "\u265C"
                        else
                          puts "That is not a queen, bishop, knight, or rook. Please choose again."
                        end
                      end
                    else
                      until @board.board[@final] == "\u2655" || @board.board[@final] == "\u2657" || @board.board[@final] == "\u2658" || @board.board[@final] == "\u2656"
                        upgrade = STDIN.gets.chomp
                        case upgrade
                        when "queen"
                          @board.board[@final] = "\u2655"
                        when "bishop"
                          @board.board[@final] = "\u2657"
                        when "knight"
                          @board.board[@final] = "\u2658"
                        when "rook"
                          @board.board[@final] = "\u2656"
                        else
                          puts "That is not a queen, bishop, knight, or rook. Please choose again."
                        end
                      end
                    end
                  else
                    if piece == @pieces.pawn_black
                      @board.board[@final] = "\u265B"
                    else
                      @board.board[@final] = "\u2655"
                    end
                  end
                end
                if (human == nil)
                  check?
                end
                @landing = @final
                if human == nil
                  puts "Successful move."
                end
                return "Successful move."
              else
                if human == nil
                  puts "You cannot move through pieces."
                end
              return "You cannot move through pieces."
              end
            end
          end
          @board.board[@final] = @board.board[starting]
          @board.board[starting] = " "
          if @turn == "black"
            @turn = "white"
          else
            @turn = "black"
          end
          if human == nil
            puts "Successful move."
          end
          return "Successful move."
        else
          if human == nil
            puts "That is an illegal move inner."
          end
          return "That is an illegal move inner."
        end
      else
        if human == nil
          puts "That is an illegal move."
        end
        return "That is an illegal move."
      end
    end
  end

  def position_locator
    @black_position_locator = []
    @white_position_locator = []
    @board.board.select do |k,v|
      if v == "\u265C" || v == "\u265E" || v == "\u265D" || v == "\u265B" || v == "\u265A" || v == "\u265F"
        @black_position_locator << k
      end
    end
    @board.board.select do |k,v|
      if v == "\u2656" || v == "\u2658" || v == "\u2657" || v == "\u2655" || v == "\u2654" || v == "\u2659"
        @white_position_locator << k
      end
    end
    return "#{@black_position_locator}\n#{@white_position_locator}"
  end

  def move_generator
    if @turn == "black"
      @actual_turn = "black"
    else
      @actual_turn = "white"
    end
    boar = @board.board.dup
    position_locator
    @potential_black_moves = []
    @potential_white_moves = []
    @black_position_locator.each do |x|
      black_turn = "black"
      piece_potential_moves = []
      piece = @board.board[x]
      case piece 
      when "\u265C"
        piece_potential_moves = @pieces.rook_potential_moves
      when "\u265E"
        piece_potential_moves = @pieces.knight_potential_moves
      when "\u265D"
        piece_potential_moves = @pieces.bishop_potential_moves
      when "\u265B"
        piece_potential_moves = @pieces.queen_potential_moves
      when "\u265A"
        piece_potential_moves = @pieces.king_potential_moves
      when "\u265F"
        piece_potential_moves = @pieces.pawn_black_potential_moves + @pieces.pawn_black_potential_diagonal_moves
      end
      piece_potential_moves.each do |y|
        if move(x,y,"ImAGhost") == "Successful move."
          @board.board = boar.dup
          @turn = @actual_turn
          start = x.split(",")
          move = y.split(",")
          c = start[0].to_i + move[0].to_i
          d = start[1].to_i + move[1].to_i
          @final = "#{c},#{d}"
          if black_position_locator.include? @final
          else
            @potential_black_moves << @final
          end
        else
          @turn = black_turn
        end
      end
    end
    @white_position_locator.each do |x|
      white_turn = "white"
      piece_potential_moves = []
      piece = @board.board[x]
      case piece 
      when "\u2656"
        piece_potential_moves = @pieces.rook_potential_moves
      when "\u2658"
        piece_potential_moves = @pieces.knight_potential_moves
      when "\u2657"
        piece_potential_moves = @pieces.bishop_potential_moves
      when "\u2655"
        piece_potential_moves = @pieces.queen_potential_moves
      when "\u2654"
        piece_potential_moves = @pieces.king_potential_moves
      when "\u2659"
        piece_potential_moves = @pieces.pawn_white_potential_moves + @pieces.pawn_white_potential_diagonal_moves
      end
      piece_potential_moves.each do |y|
        if move(x,y,"ImAGhost") == "Successful move."
          @board.board = boar.dup
          @turn = @actual_turn
          start = x.split(",")
          move = y.split(",")
          c = start[0].to_i + move[0].to_i
          d = start[1].to_i + move[1].to_i
          @final = "#{c},#{d}"
          if white_position_locator.include? @final
          else
            @potential_white_moves << @final
          end
        else
          @turn = white_turn
        end
      end
    end
    
    return "#{@potential_black_moves.count}\n#{@potential_black_moves}\n#{@potential_white_moves.count}\n#{@potential_white_moves}"
  end

  def check?
    move_generator
    @turn = @actual_turn
    if @potential_white_moves.include? @board.board.key("\u265A")
      @black_king_check = true
      return "Check!"
    elsif @potential_black_moves.include? @board.board.key("\u2654")
      @white_king_check = true
      return "Check!"
    else
      return "Successful move."
    end
  end

  def checkmate?(starting = nil, ending = nil)
    counter = 0
    start = starting.split(",")
    move = ending.split(",")
    c = start[0].to_i + move[0].to_i
    d = start[1].to_i + move[1].to_i
    final = "#{c},#{d}"
    # p final
    move_generator
    if (counter == 0) && ((@potential_white_moves.include? @board.board.key("\u265A")) || (@potential_black_moves.include? @board.board.key("\u2654")))
      if @board.board[final] == "\u265A"
        @board.board[starting] = "\u265A"
        @board.board[final] = " "
        return "You can't put your king in check!"
      elsif @board.board[final] == "\u2654"
        @board.board[starting] = "\u2654"
        @board.board[final] = " "
        return "You can't put your king in check!"
      else
        @checkmate = true
        return "Checkmate!"
      end
    else
      return "Not checkmate"
    end
  end

  def movement(a,b)
    move(a,b)
    checkmate?(a,b)
  end

  def ui
    until @checkmate == true
      puts "Please enter the location of the piece followed by the movement you would like it to make."
      puts @board.display_board
      p @turn
      act_turn = @turn.dup
      if @turn == "black"
        a = gets.chomp
        position_locator
        until @black_position_locator.include? a
          puts "please try again"
          a = gets.chomp
        end
      elsif @turn == "white"
        a = gets.chomp
        position_locator
        until @white_position_locator.include? a
          puts "please try again"
          a = gets.chomp
        end
      end
      # a = gets.chomp
      b = gets.chomp
      movement(a,b)
      if act_turn == "black"
        @turn = "white"
      else
        @turn = "black"
      end
    puts @board.display_board
    end
  end
end

game = Game.new
game.ui