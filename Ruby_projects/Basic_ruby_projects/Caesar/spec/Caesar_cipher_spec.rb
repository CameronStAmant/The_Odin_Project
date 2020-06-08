require './lib/Caesar_cipher.rb'

describe CC do
  describe "#caesar_cipher" do
    it "Encrypts the string" do
      cipher = CC.new
      expect(cipher.caesar_cipher("What a string!", 5)).to eql("Bmfy f xywnsl!")
    end
  end
  
  describe "#caesar_cipher" do
    it "Does not change a non-alphanumeric character" do
      cipher = CC.new
      expect(cipher.caesar_cipher("1.", 5)).to eql("1.")
    end
  end

end