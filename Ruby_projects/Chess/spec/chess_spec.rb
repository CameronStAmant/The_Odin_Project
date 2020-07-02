require "./lib/chess.rb"

describe Game do
#move

  describe "#move" do
    it "does not allow a player to go on top of their own piece" do
      game = Game.new
      expect(game.move("8,2", "-1,2")).to eql("You cannot move onto one of your pieces.")
    end

    it "allows a player to move onto an enemies space" do
      game = Game.new
      game.move("8,2", "-2,1")
      game.move("2,1","1,0")
      game.move("6,3", "-2,1")
      game.move("2,2","1,0")
      expect(game.move("4,4", "-2,1")).to eql("Successful move.")
    end

    it "does not allow any pieces, other than knights, to move through other pieces" do
      game = Game.new
      game.move("7,1","-2,0")
      game.move("2,1","2,0")
      game.move("8,1","-2,0")
      game.move("2,2","2,0")
      game.move("6,1","0,1")
      game.move("2,3","2,0")
      expect(game.move("6,2","-3,0")).to eql("You cannot move through pieces.")
    end

    it "does allow a piece to destroy another piece" do
      game = Game.new
      game.move("7,1","-2,0")
      game.move("2,1","2,0")
      game.move("8,1","-2,0")
      game.move("2,2","2,0")
      game.move("6,1","0,1")
      game.move("2,3","2,0")
      expect(game.move("6,2","-2,0")).to eql("Successful move.")
    end

    it "allows players to save the game" do
      game = Game.new
      game.move("7,1", "-2,0")
      game.move("2,1","1,0")
      expect(game.move("save")).to eql("Game saved!")
    end

    it "allows players to load a saved game" do
      game = Game.new
      expect(game.move("load")).to eql("Game loaded!")
    end

    it "does not allow players to only give a starting location" do
    end

    it "does not allow players to only give a move action" do
    end

#move_generator

  describe "#move_generator" do
    it "finds all potential moves for both teams" do
      game = Game.new
      game.move("7,1","-1,0")
      game.move("2,1", "1,0")
      game.move("7,2","-1,0")
      game.move("2,2", "1,0")
      game.move("7,3","-1,0")
      game.move("2,3", "1,0")
      game.move("7,4","-1,0")
      game.move("2,4", "1,0")
      game.move("7,5","-1,0")
      game.move("2,5", "1,0")
      game.move("7,6","-1,0")
      game.move("2,6", "1,0")
      game.move("7,7","-1,0")
      game.move("2,7", "1,0")
      game.move("7,8","-1,0")
      game.move("2,8", "1,0")
      expect(game.move_generator).to eql("22\n[\"7,1\", \"7,4\", \"7,2\", \"7,4\", \"7,4\", \"7,3\", \"7,5\", \"7,5\", \"7,6\", \"7,4\", \"7,5\", \"7,7\", \"7,5\", \"7,8\", \"5,1\", \"5,2\", \"5,3\", \"5,4\", \"5,5\", \"5,6\", \"5,7\", \"5,8\"]\n22\n[\"4,1\", \"4,2\", \"4,3\", \"4,4\", \"4,5\", \"4,6\", \"4,7\", \"4,8\", \"2,1\", \"2,4\", \"2,4\", \"2,2\", \"2,4\", \"2,5\", \"2,3\", \"2,5\", \"2,6\", \"2,4\", \"2,7\", \"2,5\", \"2,5\", \"2,8\"]")
    end
  end

#check

  describe "#check?" do
    it "should declare check when the black king it is in check" do
      game = Game.new
      game.move("7,1","-1,0")
      game.move("2,4", "2,0")
      game.move("7,2","-1,0")
      game.move("1,4","2,0")
      game.move("7,5","-2,0")
      game.move("3,4","0,1")
      game.move("7,8","-1,0")
      game.move("3,5","2,0")
      expect(game.check?).to eql("Check!")
    end

    it "should declare check when the white king it is in check" do
      game = Game.new
      game.move("8,2","-2,1")
      game.move("2,1","1,0")
      game.move("6,3","-2,1")
      game.move("2,5","1,0")
      game.move("4,4","-1,2")
      game.move("2,8","1,0")
      expect(game.check?).to eql("Check!")
    end
  end

    it "enforces the black king to move after being checked" do
      game = Game.new
      game.move("7,5","-1,0")
      game.move("1,2", "2,1")
      game.move("7,2","-1,0")
      game.move("3,3","2,1")
      game.move("7,3","-1,0")
      game.move("5,4","1,2")
      expect(game.move("7,1","-1,0")).to eql("You must move your king!")
    end

    it "enforces the white king to move after being checked" do
      game = Game.new
      game.move("7,4","-2,0")
      game.move("2,1","2,0")
      game.move("8,4","-2,0")
      game.move("2,5","2,0")
      game.move("6,4","0,1")
      game.move("2,8","1,0")
      game.move("6,5","-2,0")
      expect(game.move("2,7","2,0")).to eql("You must move your king!")
    end

    it "allows the black king to get out of check" do
      game = Game.new
      game.move("7,5","-1,0")
      game.move("1,2", "2,1")
      game.move("7,2","-1,0")
      game.move("3,3","2,1")
      game.move("7,3","-1,0")
      game.move("5,4","1,2")
      game.move("8,5","-1,0")
      game.move("2,1","1,0")
      expect(game.move("7,1","-1,0")).to eql("Successful move.")
    end

    it "allows the white king to get out of check" do
      game = Game.new
      game.move("7,4","-2,0")
      game.move("2,1","2,0")
      game.move("8,4","-2,0")
      game.move("2,5","2,0")
      game.move("6,4","0,1")
      game.move("1,4","2,2")
      game.move("6,5","-2,0")
      game.move("1,5","0,-1")
      game.move("7,1","-1,0")
      expect(game.move("2,2","1,0")).to eql("Successful move.")
    end

    it "allows other black pieces to get the black king out of check" do
      game = Game.new
      game.move("7,5","-2,0")
      game.move("2,5","1,0")
      game.move("7,4","-2,0")
      game.move("1,4","2,2")
      game.move("8,4","-2,0")
      game.move("3,6","1,-1")
      game.move("7,1","-1,0")
      game.move("4,5","1,0")
      expect(game.move("6,4","0,1")).to eql("Successful move.")
    end

    it "allows other white pieces to get the white king out of check" do
      game = Game.new
      game.move("7,4","-2,0")
      game.move("2,1","2,0")
      game.move("8,4","-2,0")
      game.move("2,5","2,0")
      game.move("6,4","0,1")
      game.move("1,4","2,2")
      game.move("6,5","-2,0")
      expect(game.move("3,6","0,-1")).to eql("Successful move.")
    end

    it "requires the black king to move if the next move does not get them out of check" do
      game = Game.new
      game.move("7,5","-2,0")
      game.move("2,5","1,0")
      game.move("7,4","-2,0")
      game.move("1,4","2,2")
      game.move("8,4","-2,0")
      game.move("3,6","1,-1")
      game.move("7,1","-1,0")
      game.move("4,5","1,0")
      expect(game.move("7,2","-1,0")).to eql("You must move your king!")
    end

    it "requires the white king to move if the next move does not get them out of check" do
      game = Game.new
      game.move("7,4","-2,0")
      game.move("2,1","2,0")
      game.move("8,4","-2,0")
      game.move("2,5","2,0")
      game.move("6,4","0,1")
      game.move("1,4","2,2")
      game.move("6,5","-2,0")
      expect(game.move("3,6","1,0")).to eql("You must move your king!")
    end

    it "allows the black team to capture the white piece that is putting them in check" do
      game = Game.new
      game.move("7,5","-2,0")
      game.move("2,5","1,0")
      game.move("7,4","-2,0")
      game.move("1,4","2,2")
      game.move("8,4","-2,0")
      game.move("3,6","1,-1")
      game.move("7,1","-1,0")
      game.move("4,5","1,0")
      expect(game.move("6,4","-1,1")).to eql("Successful move.")
    end

    it "allows the white team to capture the black piece that is putting them in check" do
      game = Game.new
      game.move("7,4","-2,0")
      game.move("2,1","2,0")
      game.move("8,4","-2,0")
      game.move("2,5","2,0")
      game.move("6,4","0,1")
      game.move("1,4","2,2")
      game.move("6,5","-2,0")
      expect(game.move("3,6","1,-1")).to eql("Successful move.")
    end

    # it "does not allow the black king to put themselves into check" do
    #   game = Game.new
    #   game.move("7,5","-1,0")
    #   game.move("2,5","1,0")

    #   game.move("8,5","-1,0")
    #   game.move("1,4","2,2")

    #   game.move("7,5","-1,-1")
    #   game.move("3,6","3,0")

    #   game.move("6,4","-1,-1")
    #   game.move("2,8","1,0")

    #   game.move("5,3","-1,-1")
    #   game.move("6,6","-1,0")

    #   game.move("7,8","-2,0")
    #   game.move("5,6","0,-2")

    #   game.move("6,5","-1,0")
    #   game.move("2,2","1,0")

    #   game.move("8,8","-2,0")
    #   game.move("2,7","1,0")

    #   game.move("6,8","0,-7")
    #   game.move("2,6","1,0")

    #   puts game.board.display_board
    #   expect(game.move("4,2","1,0")).to eql("You can't put yourself in check.")
    #   puts game.board.display_board
    # end

    # it "does not allow the white king to put themselves into check" do
    #   game = Game.new
    #   game.move("7,1","-2,0")
    #   game.move("2,5","1,0")

    #   game.move("8,1","-2,0")
    #   game.move("1,5","1,0")

    #   game.move("6,1","0,1")
    #   game.move("2,5","1,1")

    #   game.move("6,2","-1,0")
    #   game.move("3,6","1,0")

    #   game.move("5,2","-1,0")
    #   game.move("4,6","1,0")

    #   game.move("7,6","-1,0")
    #   game.move("2,1","1,0")

    #   game.move("7,7", "-2,0")
    #   game.move("2,2", "1,0")

    #   game.move("7,8", "-2,0")
    #   game.move("2,3", "1,0")

    #   game.move("7,5", "-2,0")
    #   game.move("5,6", "1,1")

    #   game.move("8,8", "-1,0")
    #   game.move("2,4", "1,0")

    #   game.move("4,2", "1,0")
    #   game.move("2,6", "1,0")

    #   game.move("7,4", "-2,0")
    #   game.move("2,7", "1,0")

    #   game.move("5,5", "-1,0")
    #   game.move("2,8", "1,0")

    #   game.move("5,4", "-1,0")
    #   game.move("3,1", "1,0")

    #   game.move("5,7", "-1,0")
    #   game.move("3,2", "1,0")

    #   game.move("6,6", "-1,0")
    #   game.move("3,3", "1,0")

    #   game.move("5,6", "-1,0")
    #   game.move("4,2", "1,-1")
      
    #   game.move("8,4", "-1,0")
    #   game.move("3,8", "1,0")

    #   game.move("8,7", "-2,1")
    #   game.move("3,7", "1,-1")

    #   game.move("4,7", "-1,0")
    #   expect(game.move("6,7", "1,-1")).to eql("You can't put yourself in check.")
    # end

#checkmate

    it "confirms the black king is checkmated" do
      game = Game.new
      game.move("7,5","-1,0")
      game.move("2,5","1,0")
      game.move("8,5","-1,0")
      game.move("1,4","2,2")
      game.move("7,5","-1,-1")
      game.move("3,6","3,0")
      game.move("6,4","-1,-1")
      game.move("2,8","1,0")
      game.move("5,3","-1,-1")
      game.move("6,6","-1,0")
      game.move("7,4","-1,0")
      game.move("5,6","0,-2")
      game.move("6,5","-1,0")
      game.move("2,2","1,0")
      game.move("7,8","-1,0")
      game.move("2,1","1,0")
      puts game.board.display_board
      expect(game.checkmate?).to eql("Checkmate!")
      puts game.board.display_board

    end

    it "confirms the white king is checkmated" do
      game = Game.new
      game.move("7,1","-2,0")
      game.move("2,5","1,0")

      game.move("8,1","-2,0")
      game.move("1,5","1,0")

      game.move("6,1","0,1")
      game.move("2,5","1,1")

      game.move("6,2","-1,0")
      game.move("3,6","1,0")

      game.move("5,2","-1,0")
      game.move("4,6","1,0")

      game.move("7,6","-1,0")
      game.move("2,1","1,0")

      game.move("7,7", "-2,0")
      game.move("2,2", "1,0")

      game.move("7,8", "-2,0")
      game.move("2,3", "1,0")

      game.move("7,5", "-2,0")
      game.move("5,6", "1,1")

      game.move("8,8", "-1,0")
      game.move("2,4", "1,0")

      game.move("4,2", "1,0")
      game.move("2,6", "1,0")

      game.move("7,4", "-2,0")
      game.move("2,7", "1,0")

      game.move("5,5", "-1,0")
      game.move("2,8", "1,0")

      game.move("5,4", "-1,0")
      game.move("3,1", "1,0")

      game.move("5,7", "-1,0")
      game.move("3,2", "1,0")

      game.move("6,6", "-1,0")
      game.move("3,3", "1,0")

      game.move("5,6", "-1,0")
      game.move("4,2", "1,-1")
      
      game.move("8,4", "-1,0")
      game.move("3,8", "1,0")

      game.move("8,7", "-2,1")
      game.move("3,7", "1,-1")

      game.move("4,7", "-1,0")
      game.move("6,7", "0,-1")

      game.move("7,4", "-1,0")
      expect(game.checkmate?).to eql("Checkmate!")
    end

    it "allows the white king to get out of checkmate by capturing the checking piece from the other team" do
      game = Game.new
      game.move("7,1","-2,0")
      game.move("2,5","1,0")

      game.move("8,1","-2,0")
      game.move("1,5","1,0")

      game.move("6,1","0,1")
      game.move("2,5","1,1")

      game.move("6,2","-1,0")
      game.move("3,6","1,0")

      game.move("5,2","-1,0")
      game.move("4,6","1,0")

      game.move("7,6","-1,0")
      game.move("2,1","1,0")

      game.move("7,7", "-2,0")
      game.move("2,2", "1,0")

      game.move("7,8", "-2,0")
      game.move("2,3", "1,0")

      game.move("7,5", "-2,0")
      game.move("5,6", "1,1")

      game.move("8,8", "-1,0")
      game.move("2,4", "1,0")

      game.move("4,2", "1,0")
      game.move("2,6", "1,0")

      game.move("7,4", "-2,0")
      game.move("2,7", "1,0")

      game.move("5,5", "-1,0")
      game.move("2,8", "1,0")

      game.move("5,4", "-1,0")
      game.move("3,1", "1,0")

      game.move("5,7", "-1,0")
      game.move("3,2", "1,0")

      game.move("6,6", "-1,0")
      game.move("3,3", "1,0")

      game.move("5,6", "-1,0")
      game.move("4,2", "1,-1")
      
      game.move("8,4", "-1,0")
      game.move("3,8", "1,0")

      game.move("8,7", "-2,1")
      game.move("3,7", "1,-1")

      game.move("4,7", "-1,0")
      game.move("6,7", "0,-1")

      game.move("5,2", "0,2")
      game.move("4,3", "1,0")

      game.move("7,4", "-1,0")
      game.move("5,3", "1,1")
      expect(game.checkmate?).to eql("Not checkmate")
    end

    it "implements checkmate into the game for the black king" do
      game = Game.new
      game.move("7,5","-1,0")
      game.move("2,5","1,0")
      game.move("8,5","-1,0")
      game.move("1,4","2,2")
      game.move("7,5","-1,-1")
      game.move("3,6","3,0")
      game.move("6,4","-1,-1")
      game.move("2,8","1,0")
      game.move("5,3","-1,-1")
      game.move("6,6","-1,0")
      game.move("7,4","-1,0")
      game.move("5,6","0,-2")
      game.move("6,5","-1,0")
      game.move("2,2","1,0")
      game.move("7,8","-1,0")
      puts game.board.display_board
      expect(game.move1("2,1","1,0")).to eql("Checkmate!")
      puts game.board.display_board
    end

    it "implements checkmate into the game for the white king" do
    end
# black rook

    it "allows the black rook to move in any direction" do
      game = Game.new
      game.move("7,1", "-2,0")
      game.move("2,1","1,0")
      game.move("8,1", "-2,0")
      game.move("2,2","1,0")
      game.move("6,1", "0,3")
      game.move("2,3","1,0")
      game.move("6,4", "-3,0")
      game.move("2,8","1,0")
      game.move("3,4", "0,-1")
      game.move("2,5","1,0")
      expect(game.move("3,3", "2,0")).to eql("Successful move.")
    end

    it "does not allow the black rook to move illegally on the board" do
      game = Game.new
      expect(game.move("8,1", "-1,1")).to eql("That is an illegal move.")
    end

    it "does not allow the black rook to move illegally off the board" do
      game = Game.new
      expect(game.move("8,1", "1,0")).to eql("That is an illegal move inner.")
    end

    it "does not allow rook pieces to vertically go through other pieces on the same team" do
      game = Game.new
      expect(game.move("8,1", "-2,0")).to eql("You cannot move through pieces.")
    end

    it "does not allow rook pieces to horizontally go through other pieces on the same team" do
      game = Game.new
      game.move("7,1","-1,0")
      game.move("2,1","1,0")
      game.move("7,3","-1,0")
      game.move("2,2","1,0")
      game.move("8,1","-1,0")
      game.move("2,3","1,0")
      expect(game.move("7,1", "0,2")).to eql("You cannot move through pieces.")
    end

# white rook

    it "allows the white rook to move in any direction" do
      game = Game.new
      game.move("7,1","-1,0")
      game.move("2,1", "2,0")
      game.move("7,2","-1,0")
      game.move("1,1", "2,0")
      game.move("7,3","-1,0")
      game.move("3,1", "0,3")
      game.move("7,4","-1,0")
      game.move("3,4", "2,0")
      game.move("7,5","-1,0")
      game.move("5,4", "0,-1")
      game.move("7,6","-1,0")
      expect(game.move("5,3", "-1,0")).to eql("Successful move.")
    end


# black knight

    it "allows the knight to move" do
      game = Game.new
      game.move("8,2","-2,1")
      game.move("2,1","1,0")
      game.move("6,3","-1,-2")
      game.move("2,2","1,0")
      game.move("5,1","1,2")
      game.move("2,3","1,0")
      expect(game.move("6,3","-2,-1")).to eql("Successful move.")
    end

    it "does not allow the knight to move illegally on the board" do
      game = Game.new
      expect(game.move("8,2", "0,1")).to eql("That is an illegal move.")
    end

    it "does not allow the knight to move illegally off the board" do
      game = Game.new
      expect(game.move("8,2", "1,2")).to eql("That is an illegal move inner.")
    end

# white knight

    it "allows the white knight to move in any direction" do
      game = Game.new
      game.move("1,7","2,-1")
      game.move("7,1","-1,0")
      game.move("3,6", "1,-2")
      game.move("7,2","-1,0")
      game.move("4,4","-1,2")
      game.move("7,3","-1,0")
      expect(game.move("3,6", "1,2")).to eql("Successful move.")
    end


# black bishop

    it "allows the bishop to move" do
      game = Game.new
      game.move("7,2", "-1,0")
      game.move("2,1","1,0")
      expect(game.move("8,3","-2,-2")).to eql("Successful move.")
    end

    it "does not allow the bishop to move illegally on the board" do
      game = Game.new
      expect(game.move("8,3", "5,3")).to eql("That is an illegal move.")
    end

    it "does not allow the bishop to move illegally off the board" do
      game = Game.new
      expect(game.move("8,3", "1,1")).to eql("That is an illegal move inner.")
    end

    it "does not allow bishop pieces to go diagonally negative left through other pieces on the same team" do
      game = Game.new
      expect(game.move("8,3", "-2,-2")).to eql("You cannot move through pieces.")
    end

    it "does not allow bishop pieces to go diagonally negative right through other pieces on the same team" do
      game = Game.new
      expect(game.move("8,3", "-2,2")).to eql("You cannot move through pieces.")
    end

    it "does not allow bishop pieces to go diagonally left through other pieces on the same team" do
      game = Game.new
      game.move("7,5","-1,0")
      game.move("2,1","1,0")
      game.move("8,6","-2,-2")
      game.move("2,2","1,0")
      game.move("8,2","-2,-1")
      game.move("2,3","1,0")
      expect(game.move("6,4","2,-2")).to eql("You cannot move through pieces.")
    end

    it "does not allow bishop pieces to go diagonally right through other pieces on the same team" do
      game = Game.new
      game.move("7,4","-1,0")
      game.move("2,1","1,0")
      game.move("8,3","-2,2")
      game.move("2,2","1,0")
      game.move("8,7","-2,1")
      game.move("2,3","1,0")
      expect(game.move("6,5","2,2")).to eql("You cannot move through pieces.")
    end

# white bishop

    it "allows the white bishop to move" do
      game = Game.new
      game.move("7,1","-1,0")
      game.move("2,7", "1,0")
      game.move("7,2","-1,0")
      game.move("1,6","1,1")
      game.move("7,3","-1,0")
      game.move("2,7","3,-3")
      game.move("7,4","-1,0")
      game.move("5,4","-1,-1")
      game.move("7,5","-1,0")
      expect(game.move("4,3","1,-1")).to eql("Successful move.")
    end

# black queen

    it "allows the queen to move in any direction" do
      game = Game.new
      game.move("7,4","-2,0")
      game.move("2,1","1,0")
      game.move("8,4","-2,0")
      game.move("2,2","1,0")
      game.move("6,4","-2,2")
      game.move("2,3","1,0")
      game.move("4,6","-1,-1")
      game.move("2,4","1,0")
      game.move("3,5","1,-1")
      game.move("2,5","1,0")
      game.move("4,4","1,1")
      game.move("2,6","1,0")
      game.move("5,5","0,1")
      game.move("2,7","1,0")
      game.move("5,6","1,0")
      game.move("2,8","1,0")
      expect(game.move("6,6","0,-1")).to eql("Successful move.")
    end

    it "does not allow the queen to move through their teams piece" do
      game = Game.new
      expect(game.move("8,4","-2,0")).to eql("You cannot move through pieces.")
    end

# white queen

    it "allows the white queen to move" do
      game = Game.new
      game.move("7,1","-1,0")
      game.move("2,4","2,0")
      game.move("7,2","-1,0")
      game.move("1,4","2,0")
      game.move("7,3","-1,0")
      game.move("3,4","0,-1")
      game.move("7,4","-1,0")
      game.move("3,3","0,2")
      game.move("7,5","-1,0")
      game.move("3,5","2,0")
      game.move("7,6","-1,0")
      game.move("5,5","-1,0")
      game.move("7,7","-1,0")
      game.move("4,5","1,-1")
      game.move("7,8","-1,0")
      game.move("5,4","-1,-1")
      game.move("6,8","-1,0")
      game.move("4,3","-1,1")
      game.move("5,8","-1,0")
      game.move("3,4","1,-1")
      game.move("4,8","-1,0")
      game.move("4,3","1,1")
      game.move("3,8","-1,0")
      game.move("5,4","-1,1")
      game.move("2,8","-1,0")
      expect(game.move("4,5","1,1")).to eql("Successful move.")
    end

# black king

    it "allows the king to move in any direction" do
      game = Game.new
      game.move("7,5","-2,0")
      game.move("2,1","1,0")
      game.move("8,5","-1,0")
      game.move("2,2","1,0")
      game.move("7,5","1,0")
      game.move("2,3","1,0")
      game.move("8,5","-1,0")
      game.move("2,4","1,0")
      game.move("7,5","-1,0")
      game.move("2,5","1,0")
      game.move("6,5","0,1")
      game.move("2,6","1,0")
      game.move("6,6","0,-1")
      game.move("2,7","1,0")
      game.move("6,5","-1,-1")
      game.move("2,8","1,0")
      game.move("5,4","-1,1")
      game.move("3,1","1,0")
      game.move("4,5","1,-1")
      game.move("4,1","1,0")
      expect(game.move("5,4","1,1")).to eql("Successful move.")
    end

# white king

    it "allows the white king to move in any direction" do
      game = Game.new
      game.move("7,1","-1,0")
      game.move("2,5", "2,0")
      game.move("7,2","-1,0")
      game.move("1,5","1,0")
      game.move("7,3","-1,0")
      game.move("2,5","1,0")
      game.move("7,4","-1,0")
      game.move("3,5","0,1")
      game.move("7,5","-1,0")
      game.move("3,6","0,-1")
      game.move("7,6","-1,0")
      game.move("3,5","-1,0")
      game.move("7,7","-1,0")
      game.move("2,5","1,0")
      game.move("7,8","-1,0")
      game.move("3,5","1,1")
      game.move("6,1","-1,0")
      game.move("4,6","-1,1")
      game.move("5,1","-1,0")
      game.move("3,7","1,-1")
      expect(game.move("4,6","-1,-1")).to eql("Successful move.")
    end

# black pawn

    it "allows the black pawn to move" do
      game = Game.new
      game.move("7,4", "-2,0")
      expect(game.move("5,4", "-1,0")).to eql("Successful move.")
    end

    it "does not allow the black pawn to move illegally on the board" do
      game = Game.new
      expect(game.move("7,4", "1,0")).to eql("That is an illegal move.")
    end

    it "does not allow the black pawn to move illegally off the board" do
      game = Game.new
      game.move("7,4", "-2,0")
      game.move("2,1","1,0")
      game.move("5,4", "-1,0")
      game.move("2,2","1,0")
      game.move("4,4", "-2,0")
      game.move("2,3","1,0")
      game.move("2,4", "-1,0")
      game.move("2,5","1,0")
      expect(game.move("1,4", "-2,0")).to eql("That is an illegal move inner.")
    end

    it "does not allow pawn pieces to go through other pieces on the same team" do
      game = Game.new
      game.move("8,2", "-2,1")
      game.move("2,1","1,0")
      expect(game.move("7,3", "-2,0")).to eql("You cannot move through pieces.")
    end

    it "does not allow a black pawn to move diagonally unless they are destroying an opponent" do
      game = Game.new
      expect(game.move("7,4", "-1,1")).to eql("Bad move.")
    end

    it "allows the black pawn to move diagonally to capture an opponent" do
      game = Game.new
      game.move("7,4", "-2,0")
      game.move("2,1","1,0")
      game.move("5,4","-1,0")
      game.move("3,1","1,0")
      game.move("4,4","-1,0")
      game.move("2,8","1,0")
      game.move("3,4","-1,1")
      game.move("4,1","1,0")
      expect(game.move("2,5","-1,-1")).to eql("Successful move.")
    end

    it "allows the black pawn to change to a different piece when the end of the opposite board is reached." do
      game = Game.new
      game.move("7,4", "-2,0")
      game.move("2,1","1,0")
      game.move("5,4","-1,0")
      game.move("3,1","1,0")
      game.move("4,4","-1,0")
      game.move("2,8","1,0")
      game.move("3,4","-1,1")
      game.move("4,1","1,0")
      expect(game.move("2,5","-1,1")).to eql("Successful move.")
    end

    it "can only move two spaces on initial move" do
      game = Game.new
      game.move("7,1","-2,0")
      game.move("2,2","1,0")
      expect(game.move("5,1","-2,0")).to eql("The black pawn can only move two on their initial move. Please choose again.")
    end

# white pawn

    it "allows the white pawn to move" do
      game = Game.new
      expect(game.move("2,1", "1,0")).to eql("Successful move.")
    end

    it "allows the white pawn to change to a different piece when the end of the opposite board is reached." do
      game = Game.new
      game.move("7,1","-1,0")
      game.move("2,7", "2,0")
      game.move("6,1","-1,0")
      game.move("4,7","1,0")
      game.move("5,1","-1,0")
      game.move("5,7","1,0")
      game.move("4,1","-1,0")
      game.move("6,7","1,1")
      game.move("7,2","-1,0")
      expect(game.move("7,8","1,-1")).to eql("Successful move.")
    end

    it "allows the white pawn to move diagonally to capture an opponent" do
      game = Game.new
      game.move("7,1","-2,0")
      game.move("2,5","1,0")
      game.move("8,1","-2,0")
      game.move("1,5","1,0")
      game.move("6,1","0,1")
      game.move("2,5","1,1")
      game.move("6,2","-1,0")
      game.move("3,6","1,0")
      game.move("5,2","-1,0")
      game.move("4,6","1,0")
      game.move("7,6","-1,0")
      game.move("2,1","1,0")
      game.move("7,7", "-2,0")
      game.move("2,2", "1,0")
      game.move("7,8", "-2,0")
      game.move("2,3", "1,0")
      game.move("7,5", "-2,0")
      game.move("5,6", "1,1")
      game.move("8,8", "-1,0")
      game.move("2,4", "1,0")
      game.move("4,2", "1,0")
      game.move("2,6", "1,0")
      game.move("7,4", "-2,0")
      game.move("2,7", "1,0")
      game.move("5,5", "-1,0")
      game.move("2,8", "1,0")
      game.move("5,4", "-1,0")
      game.move("3,1", "1,0")
      game.move("5,7", "-1,0")
      game.move("3,2", "1,0")
      game.move("6,6", "-1,0")
      game.move("3,3", "1,0")
      game.move("5,6", "-1,0")
      expect(game.move("3,4", "1,1")).to eql("Successful move.")
    end
  end

#position_locator

  describe "#position_locator" do
    it "finds all positions of all pieces" do
      game = Game.new
      expect(game.position_locator).to eql("[\"8,1\", \"8,2\", \"8,3\", \"8,4\", \"8,5\", \"8,6\", \"8,7\", \"8,8\", \"7,1\", \"7,2\", \"7,3\", \"7,4\", \"7,5\", \"7,6\", \"7,7\", \"7,8\"]\n[\"2,1\", \"2,2\", \"2,3\", \"2,4\", \"2,5\", \"2,6\", \"2,7\", \"2,8\", \"1,1\", \"1,2\", \"1,3\", \"1,4\", \"1,5\", \"1,6\", \"1,7\", \"1,8\"]")
    end
  end
end

=begin
puts game.board.display_board

automate black
game = Game.new
game.move("7,1","-1,0")
game.move(",", ",")
game.move("7,2","-1,0")
game.move(",",",")
game.move("7,3","-1,0")
game.move(",",",")
game.move("7,4","-1,0")
game.move(",",",")
game.move("7,5","-1,0")
game.move(",",",")
game.move("7,6","-1,0")
game.move(",",",")
game.move("7,7","-1,0")
game.move(",",",")
game.move("7,8","-1,0")
expect(game.move(",",",")).to eql("Successful move.")
puts game.board.display_board

automate white
game = Game.new
game.move(",", ",")
game.move("2,1","1,0")
game.move(",",",")
game.move("2,2","1,0")
game.move(",",",")
game.move("2,3","1,0")
game.move(",",",")
game.move("2,4","1,0")
game.move(",",",")
game.move("2,5","1,0")
game.move(",",",")
game.move("2,6","1,0")
game.move(",",",")
game.move("2,7","1,0")
game.move(",",",")
game.move("2,8","1,0")
expect(game.move(",",",")).to eql("Successful move.")
puts game.board.display_board

=end