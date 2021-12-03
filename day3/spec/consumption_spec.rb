require_relative '../consumption'
require 'pry-byebug'

describe 'consumption checker' do
  let(:input) { 
    "00100
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
  }

  describe '#gamma' do
    it "should calculate gamma rate" do
      expect(gamma(input)).to eq(22)
    end      
  end

  describe '#epsilon' do
    it "should calculate epsilon rate" do
      expect(epsilon(input)).to eq(9)
    end      
  end
  
  describe '#power' do
    it 'should multiply gamma & epsilon rate' do
      expect(power(input)).to eq(198)      
    end    
  end
  
  describe '#life_support' do
    it 'should calculate o2 rate' do
      expect(life_support(input)[:oxygen]).to eq(23)
    end    
    
    it 'should calculate co2 rate' do
      expect(life_support(input)[:carbon]).to eq(10)
    end    
    
    it 'should calculate total rate' do
      expect(life_support(input)[:total_rate]).to eq(230)
    end    
  end
end
