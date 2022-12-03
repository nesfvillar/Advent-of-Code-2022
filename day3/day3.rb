rucksacks = File.read('input.txt').split
# rucksacks = File.read('test-input.txt').split


def get_compartments(rucksack)
    substr_length = rucksack.length / 2
    first, second = rucksack[..substr_length-1], rucksack[substr_length..]
    return first, second
end


def find_common_item(first, second)
    first.each_char {|u|
        if second.include? u
            return u
        end
    }
end


def get_char_value(c)
    if 'a' <= c && c <= 'z'
        return c.ord - 'a'.ord + 1
    elsif 'A' <= c && c <= 'Z'
        return c.ord - 'A'.ord + 27
    end
end


values = rucksacks.map {|r| 
    first, second = get_compartments(r)
    item = find_common_item(first, second)
    get_char_value(item)
}

puts values.sum
