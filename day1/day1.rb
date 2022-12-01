#Part 1
elves = File.read('input.txt').split("\n\n")
#elves = File.read('test-input.txt').split("\n\n")

calories = elves.map {|elf| 
  calories = elf.split.map! {|c| c.to_i}
  calories.sum
}
puts calories.max

#Part 2
calories.sort! {|a, b| b <=> a}
puts calories.take(3).sum

