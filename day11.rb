require "./template.rb"
file_data = loadlines(11)

$maxx = 9
$maxy = 9

grid = Array.new
file_data.each {
    |line|
    l = Array.new
    line.each_char {
        |item|
        l << item.to_i
    }
    grid << l
}

def get_adjacent(x,y)
    toret = Array.new
    if x > 0
        toret << [x-1, y]
        if y > 0
            toret << [x-1,y-1]
        end
        if y < $maxy
            toret << [x-1,y+1]
        end
    end
    if y > 0
        toret << [x, y-1]
    end
    if y < $maxy
        toret << [x, y+1]
    end
    if x < $maxx
        toret << [x+1, y]
        if y > 0
            toret << [x+1, y-1]
        end
        if y < $maxy
            toret << [x+1, y+1]
        end
    end
    return toret
end

$total = 0

def step(grid)
    toFlash = Array.new
    toZero = Array.new
    grid.each_with_index {
        |line, x|
        line.each_with_index {
            |item, y|
            grid[x][y] = item + 1
            if grid[x][y] == 10
                toFlash << [x,y]
            end
        }
    }

    while toFlash.length > 0
        item = toFlash.pop
        toZero << item
        toUpdate = get_adjacent(item[0], item[1])
        toUpdate.each {
            |other|
            grid[other[0]][other[1]] += 1
            if grid[other[0]][other[1]] == 10
                toFlash << other
            end
        }
    end

    toZero.each {
        |item|
        $total += 1
        grid[item[0]][item[1]] = 0
    }
end

def prettyprint(grid)
    grid.each {
        |line|
        puts "#{line[0]}#{line[1]}#{line[2]}#{line[3]}#{line[4]}#{line[5]}#{line[6]}#{line[7]}#{line[8]}#{line[9]}"
    }
end

for n in (1..100)
    step(grid)
end

puts($total)