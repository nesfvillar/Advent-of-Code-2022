require 'Set'

input = File.readlines('input.txt').map(&:split)
# input = File.readlines('test-input.txt').map(&:split)

class Rope
    attr_reader :visited
    include Enumerable

    def initialize
        @s = Coord.new(0, 0)
        @h = Coord.new(0, 0)
        @t = Coord.new(0, 0)
        @visited = Set.new()
    end

    def move(dir)
        move_head(dir)
        move_tail()
        update_visited()
    end

    def move_head(dir)
        @h += Coord.Directions[dir]
    end

    def move_tail
        error = @h - @t
        correction = Rope.MoveTable[error.to_a]

        if correction
            @t += correction
        end
    end

    def update_visited
        location = @t.to_a
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
            [2, -1] => Coord.Right + Coord.Down
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
r = Rope.new
instructions.each {|i| r.move(i)}
pp r.visited.count
