require './lib/tic_tac_toe.rb'

describe Game do
  describe "#play" do
    it "can have player 1 win the game" do
      b = Game.new
      allow(b).to receive(:gets).and_return("2", "6", "3", "9", "1")
      expect(b.play).to eql("Player 1 has won!")
    end

    it "can have player 2 win the game" do
      b = Game.new
      allow(b).to receive(:gets).and_return("1", "3", "2", "5", "4", "7")
      expect(b.play).to eql("Player 2 has won!")
    end

    it "can be a tie game" do
      b = Game.new
      allow(b).to receive(:gets).and_return("1", "3", "2", "4", "5", "9", "7", "8", "6")
      expect(b.play).to eql("It's a tie game!")
    end
  end
end