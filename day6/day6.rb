require 'set'

input = File.read("input.txt")
# input = File.read("test-input.txt")

def find_marker(str)
    for d in 3...str.length 
        a, b, c = d - 3, d - 2, d - 1
        chars_set = [str[a], str[b], str[c], str[d]].to_set
        if chars_set.length == 4
            return d + 1
        end
    end
end
puts find_marker(input)
