input = File.readlines('input.txt').map(&:split)
#input = File.readlines('test-input.txt').map(&:split)


# Part 1

#   | X Y Z
# --|------
# A | 4 8 3
# B | 1 5 9
# C | 7 2 6

score_map = {
  'A' => {
    'X' => 4,
    'Y' => 8,
    'Z' => 3
  },
  'B' => {
    'X' => 1,
    'Y' => 5,
    'Z' => 9
  },
  'C' => {
    'X' => 7,
    'Y' => 2,
    'Z' => 6
  }
}

scores = input.map {|first, second|
  score_map[first][second]
}
puts scores.sum


# Part 2

#   | X Y Z
# --|------
# A | 3 4 8
# B | 1 5 9
# C | 2 6 7

score_map = {
  'A' => {
    'X' => 3,
    'Y' => 4,
    'Z' => 8
  },
  'B' => {
    'X' => 1,
    'Y' => 5,
    'Z' => 9
  },
  'C' => {
    'X' => 2,
    'Y' => 6,
    'Z' => 7
  }
}

scores = input.map {|first, second|
  score_map[first][second]
}
puts scores.sum
