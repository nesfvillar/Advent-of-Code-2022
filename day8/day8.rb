input = File.read('input.txt')
# input = File.read('test-input.txt')

class Grid
    include Enumerable

    def initialize(arr, row_size)
        @grid = arr.each_slice(row_size).to_a
    end

    def get_item(i, j)
        @grid[i][j]
    end

    def each
        @grid.each_with_index {|row, i| 
            row.each_with_index {|item, j| yield [item, i, j]}
        }
    end

    def visible?(i, j)
        visible_right?(i, j) || visible_up?(i, j) || visible_left?(i, j) || visible_down?(i, j)
    end

    def visible_right?(i, j)
        size = get_item(i, j)
        items = find_right(i, j)
        unless items
            return true
        end

        items.all? {|p| p < size}
    end
    
    def visible_up?(i, j)
        size = get_item(i, j)
        items = find_up(i, j)
        unless items
            return true
            
        end

        items.all? {|p| p < size}
    end

    def visible_left?(i, j)
        size = get_item(i, j)
        items = find_left(i, j)
        unless items
            return true
        end

        items.all? {|p| p < size}
    end

    def visible_down?(i, j)
        size = get_item(i, j)
        items = find_down(i, j)
        unless items
            return true
        end

        items.all? {|p| p < size}
    end
    
    def find_right(i, j)
        @grid[i][j+1..]
    end

    def find_up(i, j)
        @grid[...i].map {|row| row[j]}
    end
    
    def find_left(i, j)
        @grid[i][...j]
    end

    def find_down(i, j)
        @grid[i+1..].map {|row| row[j]}
    end
end

size = input.index(/\n/)
arr = input.gsub!(/\n/, '').each_char.map(&:to_i)

grid = Grid.new(arr, size)
p grid.filter {|_, i, j| grid.visible?(i, j)}.count
