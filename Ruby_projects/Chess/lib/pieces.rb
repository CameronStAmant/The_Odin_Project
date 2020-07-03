class Pieces
  attr_reader :rook_black, :knight_black,:bishop_black, :queen_black, :king_black, :pawn_black, 
  :rook_potential_moves, :knight_potential_moves, :bishop_potential_moves, :queen_potential_moves, :king_potential_moves, :pawn_black_potential_moves, :pawn_white_potential_moves, :pawn_black_potential_diagonal_moves, :pawn_white_potential_diagonal_moves,
  :rook_white, :knight_white, :bishop_white, :queen_white, :king_white, :pawn_white

  def initialize
    @rook_black = "\u265C"
    @knight_black = "\u265E"
    @bishop_black = "\u265D"
    @queen_black = "\u265B"
    @king_black = "\u265A"
    @pawn_black = "\u265F"

    @rook_white = "\u2656"
    @knight_white = "\u2658"
    @bishop_white = "\u2657"
    @queen_white = "\u2655"
    @king_white = "\u2654"
    @pawn_white = "\u2659"
    
    @rook_potential_moves = [
      "-7,0","-6,0","-5,0","-4,0","-3,0","-2,0","-1,0",
      "7,0","6,0","5,0","4,0","3,0","2,0","1,0","0,-7",
      "0,-6","0,-5","0,-4","0,-3","0,-2","0,-1",
      "0,7","0,6","0,5","0,4","0,3","0,2","0,1"]
    @knight_potential_moves = ["2,1","1,2","-1,2","-2,1","-2,-1","-1,-2","1,-2","2,-1"]
    @bishop_potential_moves = [
      "-1,-1","-2,-2","-3,-3","-4,-4","-5,-5","-6,-6","-7,-7",
      "1,1","2,2","3,3","4,4","5,5","6,6","7,7",
      "-1,1","-2,2","-3,3","-4,4","-5,5","-6,6","-7,7",
      "1,-1","2,-2","3,-3","4,-4","5,-5","6,-6","7,-7"]
    @queen_potential_moves = [
      "-7,0","-6,0","-5,0","-4,0","-3,0","-2,0","-1,0",
      "7,0","6,0","5,0","4,0","3,0","2,0","1,0","0,-7",
      "0,-6","0,-5","0,-4","0,-3","0,-2","0,-1",
      "0,7","0,6","0,5","0,4","0,3","0,2","0,1",
      "-1,-1","-2,-2","-3,-3","-4,-4","-5,-5","-6,-6","-7,-7",
      "1,1","2,2","3,3","4,4","5,5","6,6","7,7",
      "-1,1","-2,2","-3,3","-4,4","-5,5","-6,6","-7,7",
      "1,-1","2,-2","3,-3","4,-4","5,-5","6,-6","7,-7"]
    @king_potential_moves = [
      "1,0","0,1","-1,0","0,-1","1,1","1,-1","-1,1","-1,-1"]
    @pawn_black_potential_moves = ["-1,0", "-2,0"]
    @pawn_black_potential_diagonal_moves = ["-1,-1","-1,1"]
    @pawn_white_potential_moves = ["1,0","2,0"]
    @pawn_white_potential_diagonal_moves = ["1,-1","1,1"]
  end
end