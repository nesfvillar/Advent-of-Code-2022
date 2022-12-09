require 'Set'

input = File.readlines('input.txt').map(&:split)
# input = File.readlines('test-input.txt').map(&:split)

class Rope
    attr_reader :visited
    include Enumerable

    def initialize(n)
        @rope = [Coord.new(0, 0)] * n
        @visited = Set.new()
    end

    def move(dir)
        move_head(dir)
        move_body()
        update_visited()
    end

    def move_head(dir)
        @rope[0] += Coord.Directions[dir]
    end

    def move_body
        @rope.each_with_index {|_, i| move_part(i) if i > 0}
    end

    def move_part(i)        
        a, b = @rope[i-1], @rope[i]
        unless a.chebyshev_distance(b) > 1
            return
        end

        x, y = (a - b).to_a
        if x > 0
            @rope[i] += Coord.Right
        elsif x < 0
            @rope[i] += Coord.Left
        end

        if y > 0
            @rope[i] += Coord.Up
        elsif y < 0
            @rope[i] += Coord.Down
        end
    end

    def update_visited
        @visited.add @rope[-1].to_a
    end
end

class Coord
    attr_reader :i, :j
    include Enumerable

    def initialize(i, j)
        @i, @j = i, j
    end

    def each
        yield @i
        yield @j
    end
    
    def +(other)
        Coord.new(@i + other.i, @j + other.j)
    end
    
    def -(other)
        Coord.new(@i - other.i, @j - other.j)
    end

    def chebyshev_distance(other)
        error = self - other
        error.map(&:abs).max
    end
    
    def self.Right
        Coord.new(1, 0)
    end

    def self.Up
        Coord.new(0, 1)
    end

    def self.Left
        Coord.new(-1, 0)
    end

    def self.Down
        Coord.new(0, -1)
    end

    def self.Directions 
        {
            "R" => self.Right,
            "U" => self.Up,
            "L" => self.Left,
            "D" => self.Down
        }
    end

end

instructions = input.map {|dir, amount| [dir] * amount.to_i}.flatten!


# Part 1

r = Rope.new(2)
instructions.each {|i| r.move(i)}
p r.visited.count


# Part 2
r = Rope.new(10)
instructions.each {|i| r.move(i)}
p r.visited.count
