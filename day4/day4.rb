require 'set'

input = File.read('input.txt').split
# input = File.read('test-input.txt').split

def str_to_enumerator(range_str)
    first, second = range_str.split('-').map(&:to_i)
    return first..second
end


# Part 1

solutions = input.map {|line| 
    sections_str = line.split(',')

    sections_set = sections_str.map {|section_str| str_to_enumerator(section_str).to_set}
    smaller, bigger = sections_set.sort_by! {|section| section.size}

    # Return true if each of the numbers in the small set is in the big set
    smaller.all? {|section| bigger.include? section}
}
puts solutions.count true


# Part 2

solutions = input.map {|line| 
    sections_str = line.split(',')

    first_set, second_set = sections_str.map {|section_str| str_to_enumerator(section_str).to_set}
    
    # Return true if any of the sections in the sets intersects
    first_set.intersect? second_set
}
puts solutions.count true
