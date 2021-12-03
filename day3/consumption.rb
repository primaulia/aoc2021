require_relative '../helpers/trim'

def process(input)
  clean_input = trim(input)
  binaries_arr = clean_input.map do |binary|
    binary.split("")
  end

  binaries_arr
end

def calculate_rate(input)
  processed_input = process(input)
  transposed_arr = processed_input.transpose

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

def calculator(measurements, opts = {
  index: 0,
  criteria: 'oxygen'
})
  return measurements.first.join if measurements.length == 1
  
  index = opts[:index]
  criteria = opts[:criteria]

  transposed_arr = measurements.transpose
  counted_arr = transposed_arr.map(&:tally)
  current_tally =  counted_arr[index]

  if current_tally["0"] == current_tally["1"]
    criteria_num = criteria == 'oxygen' ? "1" : "0"
  else
    condition = criteria == 'oxygen' ? current_tally["0"] >= current_tally["1"] : current_tally["0"] <= current_tally["1"] 
    criteria_num = condition ? "0" : "1"    
  end
  
  measurements = measurements.select do |measurement|
    measurement[index] == criteria_num
  end
  
  calculator(measurements, index: index + 1, criteria: criteria)
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

def life_support(input)
  measurements = process(input)
  results = {}
  results[:oxygen] = calculator(measurements).to_i(2)
  results[:carbon] = calculator(measurements, index: 0, criteria: 'carbon').to_i(2)
  results[:total_rate] = results[:oxygen] * results[:carbon]
  results
end