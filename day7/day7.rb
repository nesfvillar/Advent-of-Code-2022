require 'pp'
require 'strscan'

# input = File.read("input.txt")
input = File.read("test-input.txt")

class TreeNode
    attr_reader :name, :parent

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


class FileNode < TreeNode
    def initialize(weight, *args, **kwargs)
        @weight = weight
        super(*args, **kwargs)
    end

    def get_weight
        @weight
    end

    def add_child(child)
    end
end


class TreeController
    attr_reader :tree
    def initialize(console_out)
        @commands = console_out.scan(/\$.+\n/)
        @tree = nil
        @current_node = nil
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
            elsif option != '.'
                add_dir(option)
            end
        elsif command === "ls"

        end
        return true
    end
    
    def add_dir(name)
        new_dir = TreeNode.new(name, parent=@tree)
        unless @tree === nil
            @tree.add_child(new_dir)
        end
        @tree = new_dir
    end

    def add_file(weight, name)
        new_file = FileNode(weight, name, parent=@tree)
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
while controller.parse_next_command
end

