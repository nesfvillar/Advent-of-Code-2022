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
        error = a - b
        correction = Rope.MoveTable[error.to_a]
        
        if correction
            @rope[i] += correction
        end
    end

    def update_visited
        location = @rope[-1].to_a
        unless @visited.include? location
            @visited.add location
        end
    end

    def self.MoveTable
        {
            [2, 0] => Coord.Right,
            [0, 2] => Coord.Up,
            [-2, 0] => Coord.Left,
            [0, -2] => Coord.Down,
            [2, 1] => Coord.Right + Coord.Up,
            [1, 2] => Coord.Right + Coord.Up,
            [-1, 2] => Coord.Left + Coord.Up,
            [-2, 1] => Coord.Left + Coord.Up,
            [-2, -1] => Coord.Left + Coord.Down,
            [-1,-2] => Coord.Left + Coord.Down,
            [1, -2] => Coord.Right + Coord.Down,
            [2, -1] => Coord.Right + Coord.Down,
            [2, 2] => Coord.Right + Coord.Up,
            [-2, 2] => Coord.Left + Coord.Up,
            [-2, -2] => Coord.Left + Coord.Down,
            [2, -2] => Coord.Right + Coord.Down,
        }
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
