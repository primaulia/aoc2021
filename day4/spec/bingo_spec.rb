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

  xit 'should return the final score with given sequence and boards' do
    expect(bingo_check(sequence, boards)).to eql(4512)
  end  
end

describe '#bingo?' do
  let(:sequence_set) {
    [7,4,9,5,11,17,23,2,0,14,21,24].to_set
  }

  let(:set) {
    [14, 21, 17, 24, 4].to_set
  }

  it 'should returns true if the set is a subset of the sequence' do
    expect(bingo?(sequence_set, set)).to be_truthy
  end

  it 'should returns false if otherwise' do
    expect(bingo?([7,4,9,5,11,17,23,2,0,14,21].to_set, set)).to be_falsy
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

  it 'should returns total number aside from the winning set' do
    expect(score(winning_set, board)).to eq(188)
  end
end
