require 'set'

rucksacks = File.read('input.txt').split
# rucksacks = File.read('test-input.txt').split


def string_to_set(str)
    return str.each_char.to_set
end


def get_compartments(rucksack)
    substr_length = rucksack.length / 2
    first, second = rucksack[..substr_length-1], rucksack[substr_length..]
    return first, second
end


def find_common_item(first, second)
    first.each {|u|
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
    rucksack = get_compartments(r)
    first, second = rucksack.map {|compartment| string_to_set(compartment)}
    item = find_common_item(first, second)
    get_char_value(item)
}

puts values.sum


def find_badge(first, second, third)
    first.each {|u|
        if second.include?(u) && third.include?(u)
            return u
        end
    }
end


values = rucksacks.each_slice(3).map {|group|
    first, second, third = group.map {|rucksack| string_to_set(rucksack)}
    badge = find_badge(first, second, third)
    get_char_value(badge)
}

puts values.sum
