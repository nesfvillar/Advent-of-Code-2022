require 'set'

input = File.read("input.txt")
# input = File.read("test-input.txt")

class DirNode
    attr_reader :name, :parent, :children

    def initialize(name, parent=nil, children={})
        @name = name
        @parent = parent
        @children = children
    end

    def add_child(child)
        unless @children[child.name] != nil
            @children[child.name] = child
        end
    end

    def get_weight
        @children.each_value.sum {|child| child.get_weight}
    end

    def map_weights
        map = {}
        q = [self]
        while q.length > 0
            current_node = q.shift
            map[current_node] = current_node.get_weight

            child_dirs = current_node.children.each_value.filter {|child| child.class == DirNode}
            child_dirs.each {|c| q << c unless map.include? c}
        end

        return map
    end
end


class FileNode
    attr_reader :name
    def initialize(name, weight, parent)
        @name = name
        @weight = weight
        @parent = parent
    end

    def get_weight
        @weight
    end
end


class TreeController
    def initialize(console_out)
        @commands = console_out.scan(/\$.+\n/)
        @command_results = console_out.split(/\$.+\n/).filter {|op| op != ''}
        @tree = nil

        while parse_next_command
        end
    end
    
    def parse_next_command
        raw_command = @commands.shift
        unless raw_command
            return false
        end

        command, option = raw_command[1..].split
        if command === "cd"
            if option == '..'
                go_parent()
            else
                add_dir(option)
            end
        elsif command === "ls"
            results = @command_results.shift.scan(/\d+ \w+.?\w*/).map!(&:split)
            results.each {|weight, name| add_file(name, weight.to_i)}
        end
        return true
    end
    
    def add_dir(name)
        new_dir = DirNode.new(name, parent=@tree)
        unless @tree === nil
            @tree.add_child(new_dir)
        end
        @tree = new_dir
    end

    def add_file(name, weight)
        new_file = FileNode.new(name, weight, @tree)
        @tree.add_child(new_file)
    end

    def go_parent
        @tree = @tree.parent
    end

    def root
        root = @tree
        while root.parent
            root = root.parent
        end
        return root
    end
end

controller = TreeController.new(input)
weight_map = controller.root.map_weights


# Part 1
p weight_map.each_value.filter {|weight| weight < 100000}.sum


# Part 2
TOTAL_SIZE = 70000000
NEEDED_FREE_SIZE = 30000000
used_size = controller.root.get_weight
free_size = TOTAL_SIZE - used_size

valid_nodes = weight_map.each.filter{|node, weight| (free_size + weight) > NEEDED_FREE_SIZE}
valid_nodes.sort! {|a, b| a[1] <=> b[1]}
p valid_nodes[0][1]
