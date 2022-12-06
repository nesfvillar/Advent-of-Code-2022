require 'set'

input = File.read("input.txt")
# input = File.read("test-input.txt")

def find_marker(str, size)
    for i in size...str.length
        indexes = i-size...i
        chars_set = indexes.map {|j| str[j]}.to_set
        if chars_set.length == size
            return i
        end
    end
end

# Part 1
puts find_marker(input, 4)


# Part 2
puts find_marker(input, 14)
