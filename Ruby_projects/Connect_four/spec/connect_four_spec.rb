require "./lib/connect_four.rb"

describe Setup do
  describe "#choose_color" do
    it "allows the players to choose their color" do
      setup = Setup.new
      allow(setup).to receive(:gets).and_return("x")
      expect(setup.choose_color).to eql(["x", "o"])
    end

    it "only allows permitted colors" do
      setup = Setup.new
      allow(setup).to receive(:gets).and_return("green", "o")
      expect(setup.choose_color).to eql(["o", "x"])
    end
  end
end

describe Play do
  describe "#turn" do
    it "can have a player win vertically" do
      game = Game.new
      allow(game.setup).to receive(:gets).and_return("x")
      game.setup.choose_color
      allow(game.play).to receive(:gets).and_return("2", "3", "2", "3", "2", "3", "2")
      game.play.turn(player: game.setup, board: game.setup.board1)
      expect(game.setup.display_board).to eql([[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],[" ","x"," "," "," "," "," "],[" ","x","o"," "," "," "," "],[" ","x","o"," "," "," "," "],[" ","x","o"," "," "," "," "]])
    end

    it "can have a player win horizontally" do
      game = Game.new
      allow(game.setup).to receive(:gets).and_return("x")
      game.setup.choose_color
      allow(game.play).to receive(:gets).and_return("1", "1", "2", "2", "3", "3", "4")
      game.play.turn(player: game.setup, board: game.setup.board1)
      expect(game.setup.display_board).to eql([[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],["o","o","o"," "," "," "," "],["x","x","x","x"," "," "," "]])
    end

    it "can have a player win diagonally right" do
      game = Game.new
      allow(game.setup).to receive(:gets).and_return("x")
      game.setup.choose_color
      allow(game.play).to receive(:gets).and_return("2", "3", "3", "4", "4", "5", "4", "5", "5", "1", "5")
      game.play.turn(player: game.setup, board: game.setup.board1)
      expect(game.setup.display_board).to eql([[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],[" "," "," "," ","x"," "," "],[" "," "," ","x","x"," "," "],[" "," ","x","x","o"," "," "],["o","x","o","o","o"," "," "]])
    end

    it "can have a player win diagonally left" do
      game = Game.new
      allow(game.setup).to receive(:gets).and_return("x")
      game.setup.choose_color
      allow(game.play).to receive(:gets).and_return("5", "4", "4", "3", "3", "2", "3", "2", "2", "6", "2")
      game.play.turn(player: game.setup, board: game.setup.board1)
      expect(game.setup.display_board).to eql([[" "," "," "," "," "," "," "],[" "," "," "," "," "," "," "],[" ","x"," "," "," "," "," "],[" ","x","x"," "," "," "," "],[" ","o","x","x"," "," "," "],[" ","o","o","o","x","o"," "]])
    end
  end
end