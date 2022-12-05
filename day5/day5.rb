crates_str, movements_str = File.read('input.txt').split(/\n\n/)
# crates_str, movements_str = File.read('test-input.txt').split(/\n\n/)
crates = crates_str.split(/\n/)[..-2].map! {|row| 
    row.gsub!(/\s{4}/, ' - ')
    row.gsub!(/\[|\]/, ' ')
    row.split
}

movements = movements_str.split(/\n/).map! {|row|
    row.scan(/\d+/).map! &:to_i
}

class Depot
    attr_reader :stacks

    def initialize(depot)
        @stacks = {}
        for i in 0...depot[0].length
            @stacks[i] = depot.map {|row|
                row[i]
            }
            while !@stacks[i].empty? && @stacks[i][0] === '-'
                @stacks[i].shift
            end
        end
    end

    def move_crate(times, from, to)
        from_crate = @stacks[from-1]
        to_crate = @stacks[to-1]

        for i in 0...times
            crate = from_crate.shift
            to_crate.unshift crate
        end
    end

    def move_crate_ordered(times, from, to)
        from_crate = @stacks[from-1]
        to_crate = @stacks[to-1]

        crate = from_crate.shift(times)
        to_crate.unshift(*crate)
    end

    def get_top_crates
        message = ""
        for i in 0...@stacks.length
            message += @stacks[i][0] if @stacks[i][0] != nil
        end
        return message
    end
end


# Part 1

depot = Depot.new(crates)
movements.each {|times, from, to|
    depot.move_crate(times, from, to)
}
puts depot.get_top_crates


# Part 2

depot = Depot.new(crates)
movements.each {|times, from, to|
    depot.move_crate_ordered(times, from, to)
}
puts depot.get_top_crates
