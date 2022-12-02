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

# Part 1

actions = {
  'A' => RPS::ROCK,
  'B' => RPS::PAPER,
  'C' => RPS::SCISSORS,
  'X' => RPS::ROCK,
  'Y' => RPS::PAPER,
  'Z' => RPS::SCISSORS
}

def get_winner(first, second)
  if first === second
    return RPS::TIE
  end

  if first === RPS::ROCK
    if second === RPS::PAPER
      return RPS::SECOND_WON
    end
  elsif first === RPS::PAPER
    if second === RPS::SCISSORS
      return RPS::SECOND_WON
    end
  else
    if second === RPS::ROCK
      return RPS::SECOND_WON
    end
  end
  return RPS::FIRST_WON
end

scores = input.map {|plays|
  first, second = plays.map {|p| actions[p]}
  second + get_winner(first, second)
}

puts scores.sum

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

