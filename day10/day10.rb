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
        op, v = ops
        if op === 'addx'
            addx(v.to_i)
        elsif op === 'noop'
            noop()
        end
        add_current_signal()
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
end

cpu = Cpu.new
input.each {|op, v| 
    cpu.do_op(op, v)
}

times = [20, 60, 100, 140, 180, 220]
results = times.map {|t| 
    if cpu.signals[t]
        signal = cpu.signals[t]
    else
        signal = cpu.signals[t-1]
    end
    t * signal
}
pp results.sum

