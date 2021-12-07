require_relative '../bingo'

describe '#bingo_check' do
  let(:sequence) { 
    "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1" 
  }

  let(:boards) {
    "22 13 17 11  0
    8  2 23  4 24
   21  9 14 16  7
    6 10  3 18  5
    1 12 20 15 19
   
    3 15  0  2 22
    9 18 13 17  5
   19  8  7 25 23
   20 11 10 24  4
   14 21 16 12  6
   
   14 21 17 24  4
   10 16 15  9 19
   18  8 23 26 20
   22 11 13  6  5
    2  0 12  3  7"
  }

  it 'should return the final score with given sequence and boards' do
    expect(bingo_check(sequence, boards)).to eql(4512)
  end  
end

describe '#bingo?' do
  let(:sequence_set) {
    [7,4,9,5,11,17,23,2,0,14,21,24]
  }

  let(:set) {
    [14, 21, 17, 24, 4,
     10, 16, 15,  9, 19,
     18,  8, 23, 26, 20,
     22, 11, 13,  6,  5,
     2,  0,  12,  3,  7]
  }

  it 'should returns true if the set is a subset of the sequence' do
    expect(bingo?(sequence_set, set)).to be_truthy
  end

  it 'should returns false if otherwise' do
    expect(bingo?([7,4,9,5,11,17,23,2,0,14,21], set)).to be_falsy
  end

  it "should returns false if it's not in a sequential row" do
    expect(bingo?(sequence_set, [14, 21, 17, 8, 4,
      10, 16, 15,  24, 19,
      18,  8, 23, 26, 20,
      22, 11, 13,  6,  5,
      2,  0,  12,  3,  7])).to be_falsy
  end

  it "should returns true if it's in a sequential column" do
    expect(bingo?(sequence_set, [
      14, 2, 1, 24, 8, 
      21, 2, 3, 4, 1,
      17, 1, 1, 1, 1,
      24, 1, 2, 2, 2,
      4, 1, 1, 1, 1])).to be_truthy
  end
end

describe '#score' do
  let(:winning_set) {
    [7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21, 24]
  }

  let(:board) {
    [
      14,21,17,24, 4,
      10,16,15, 9, 19,
      18, 8, 23, 26, 20,
      22, 11, 13, 6, 5,
      2, 0, 12, 3, 7
    ]
  }

  it 'should returns total number aside from the winning set times the last number on the sequence' do
    expect(score(winning_set, board)).to eq(4512)
  end
end
