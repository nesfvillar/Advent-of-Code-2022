require 'pp'
require 'set'

# input = File.read("input.txt")
input = File.read("test-input.txt")

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

    def self.get_result(node, max_weight)
        child_dirs = node.children.each_value.filter {|child| child.class == DirNode}        
        if node.get_weight > max_weight
            return child_dirs.sum {|d| TreeController.get_result(d, max_weight)}
        else
            return node.get_weight + child_dirs.sum {|d| TreeController.get_result(d, max_weight)}
        end
    end
end


controller = TreeController.new(input)
while controller.parse_next_command
end

p TreeController.get_result(controller.root, 100000)
