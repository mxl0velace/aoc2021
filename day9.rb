require './template.rb'
file_data = loadlines(9)

vents = Array.new
maxx = 0
maxy = 0

file_data.each_with_index {
    |line, i|
    vents.push (Array.new)
    maxx = i
    maxy = 0
    line.each_char {
        |c|
        maxy += 1
        vents[i].push c.to_i
    }
}

maxy -= 1

def get_min_neighbour(x,y,maxx,maxy,vents)
    toCheck = Array.new
    if x > 0
        toCheck << vents[x-1][y]
    end
    if y > 0
        toCheck << vents[x][y-1]
    end
    if x < maxx
        toCheck << vents[x+1][y]
    end
    if y < maxy
        toCheck << vents[x][y+1]
    end
    return toCheck.min
end

total = 0

vents.each_with_index {
    |row, i|
    row.each_with_index {
        |spot, j|
        if spot < get_min_neighbour(i,j,maxx,maxy,vents)
            total += spot + 1
        end
    }
}

puts total