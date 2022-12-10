input = File.readlines('input.txt').map(&:split)
# input = File.readlines('test-input.txt').map(&:split)

class Cpu
    attr_reader :signals

    def initialize
        @cycle = 1
        @x = 1
        @signals = {}
    end

    def do_op(*ops)
        add_current_signal()
        op, v = ops
        if op === 'addx'
            addx(v.to_i)
        elsif op === 'noop'
            noop()
        end
    end

    def addx(v)
        @cycle += 2
        @x += v
    end

    def noop
        @cycle += 1
    end

    def add_current_signal
        @signals[@cycle] = @x
    end

    def get_x_at(t)
        if @signals[t]
            return @signals[t]
        else
            return @signals[t-1]
        end
    end
end

cpu = Cpu.new
input.each {|op, v| 
    cpu.do_op(op, v)
}


# Part 1

result = [20, 60, 100, 140, 180, 220].map! {|t| t * cpu.get_x_at(t)}.sum
p result


# Part 2

class Sprite
    def initialize(x)
        @x = x
    end

    def update_position(x)
        @x = x
    end

    def inside_range(x)
        lower_bound = @x - 1
        upper_bound = @x + 1

        lower_bound <= x && x <= upper_bound
    end
end

class Crt
    attr_reader :screen
    
    def initialize(cpu)
        @WIDTH = 40
        @HEIGHT = 6

        @cpu = cpu
        @x = 0
        @cycle = 1
        @sprite = Sprite.new(cpu.get_x_at(@cycle))
        @screen = ""
    end
    
    def update_screen
        add_pixel()
        go_next_cycle()

        return @screen.length < @WIDTH * @HEIGHT
    end

    def add_pixel
        if @sprite.inside_range(@x)
            @screen << '#'
        else
            @screen << '.'
        end
    end
    
    def go_next_cycle
        @x += 1
        unless @x < @WIDTH
            @x -= @WIDTH
        end
        
        @cycle += 1
        @sprite.update_position(@cpu.get_x_at(@cycle))
    end

    def draw
        sc = @screen.each_char.each_slice(@WIDTH)
        sc.each {|line|
            puts line.join
        }
    end
end


# Part 2
crt = Crt.new(cpu)
while crt.update_screen
end

crt.draw