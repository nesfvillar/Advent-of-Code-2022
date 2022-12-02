input = File.readlines('input.txt').map(&:split)
#input = File.readlines('test-input.txt').map(&:split)

module RPS
  ROCK = 1
  PAPER = 2
  SCISSORS = 3
  
  FIRST_WON = 0
  TIE = 3
  SECOND_WON = 6
end

wins = {
  RPS::ROCK => RPS::SCISSORS,
  RPS::PAPER => RPS::ROCK,
  RPS::SCISSORS => RPS::PAPER
}

loses = {
  RPS::ROCK => RPS::PAPER,
  RPS::PAPER => RPS::SCISSORS,
  RPS::SCISSORS => RPS::ROCK
}

# Part 1

actions = {
  'A' => RPS::ROCK,
  'B' => RPS::PAPER,
  'C' => RPS::SCISSORS,
  'X' => RPS::ROCK,
  'Y' => RPS::PAPER,
  'Z' => RPS::SCISSORS
}

scores = input.map {|plays|
  first, second = plays.map {|p| actions[p]}
  if second === first
    result = RPS::TIE
  elsif second === loses[first]
    result = RPS::SECOND_WON
  else
    result = RPS::FIRST_WON
  end
  second + result 
}
puts scores.sum

# Part 2

results = {
  'X' => RPS::FIRST_WON,
  'Y' => RPS::TIE,
  'Z' => RPS::SECOND_WON
}

scores = input.map {|first, result|
  first = actions[first]
  result = results[result]
  if result === RPS::FIRST_WON
    second = wins[first]
  elsif result === RPS::TIE
    second = first
  else
    second = loses[first]
  end
  second + result
}
puts scores.sum

