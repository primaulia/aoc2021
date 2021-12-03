require_relative '../dive'
require 'pry-byebug'

describe '#distance' do
  it 'multiple length and depth correctly' do
    # 
    #   forward 5
    #   down 5
    #   forward 8
    #   up 3
    #   down 8
    #   forward 2

    #   in hash form {
    #     forward: [5, 8, 2],
    #     down: [5, 8],
    #     up: [3],
    #   }
    #

    movement = {
      forward: [5, 8, 2],
      down: [5, 8],
      up: [3],
    }

    expect(distance(movement)).to eq(150)
  end
end

describe '#distance_with_aim' do
  it 'multiple length and depth correctly with aim' do
    # 
    #   forward 5
    #   down 5
    #   forward 8
    #   up 3
    #   down 8
    #   forward 2

    #   in hash form {
    #     forward: [5, 8, 2],
    #     down: [5, 8],
    #     up: [3],
    #   }
    #

    movement = {
      forward: [5, 8, 2],
      down: [5, 8],
      up: [3],
      aim: [40, 20]
    }

    expect(distance_with_aim(movement)).to eq(900)
  end
end

describe '#process' do 
  it 'should convert strings into movement hash' do 
    input = "forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2"

    output = {
      forward: [5, 8, 2],
      down: [5, 8],
      up: [3],
      aim: [40, 20]
    }

    expect(process(input)).to eq(output)
  end
end