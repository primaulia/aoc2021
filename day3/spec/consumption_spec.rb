require_relative '../consumption'
require 'pry-byebug'

describe 'consumption checker' do
  describe '#gamma' do
    it "should calculate gamma rate" do
      input = "00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010"
  
      expect(gamma(input)).to eq(22)
    end      
  end

  describe '#epsilon' do
    it "should calculate epsilon rate" do
      input = "00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010"
  
      expect(epsilon(input)).to eq(9)
    end      
  end
  
  describe '#power' do
    it 'should multiply gamma & epsilon rate' do
      input = "00100
      11110
      10110
      10111
      10101
      01111
      00111
      11100
      10000
      11001
      00010
      01010"
  
      expect(power(input)).to eq(198)      
    end    
  end
  
end
