require_relative '../helpers/trim'

def process(input)
  clean_input = trim(input)
  binaries_arr = clean_input.map do |binary|
    binary.split("")
  end

  binaries_arr.transpose
end

def calculate_rate(input)
  transposed_arr = process(input)

  measurements = {
    gamma: '',
    epsilon: ''
  }

  counted_arr = transposed_arr.map(&:tally)
  
  counted_arr.reduce(measurements) do |measurements, counter|
    measurements[:gamma] += counter["0"] > counter["1"] ? "0" : "1"
    measurements[:epsilon] += counter["0"] < counter["1"] ? "0" : "1"
    measurements
  end
end

def gamma(input)
  rates = calculate_rate(input)

  rates[:gamma].to_i(2)
end

def epsilon(input)
  rates = calculate_rate(input)

  rates[:epsilon].to_i(2)
end

def power(input)
  gamma(input) * epsilon(input)
end