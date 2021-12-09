require './template.rb'
file_data = loadlines(9)

vents = Array.new
maxx = 0
maxy = 0

class Point
    def initialize(value,x,y)
        @value = value
        @pos = [x,y]
        @neighbours = Array.new
        @flowsFrom = Array.new
    end

    def addNeighbour(p)
        @neighbours << p
    end

    def addFlow(p)
        @flowsFrom << p
    end

    def flowsInto
        if @value == 9
            return @pos
        else
            testValue = 10
            rpos = Array.new
            @neighbours.each {
                |adj|
                if adj.getValue < testValue
                    rpos = adj.getPos
                    testValue = adj.getValue
                end
            }
            if testValue < @value
                return rpos
            else
                return @pos
            end
        end
    end

    def isLow
        @neighbours.each {
            |adj|
            if adj.getValue < @value
                return false
            end
        }
        return true
    end

    def getValue
        return @value
    end

    def getPos
        return @pos
    end

    def getNeighbours
        return @neighbours
    end

    def getBasinSize
        total = 1
        @flowsFrom.each {
            |spot|
            total += spot.getBasinSize
        }
        return total
    end
end

file_data.each_with_index {
    |line, i|
    vents.push (Array.new)
    maxx = i
    maxy = 0
    j = 0
    line.each_char {
        |c|
        maxy += 1
        vents[i].push Point.new(c.to_i, i, j)
        j += 1
    }
}

maxy -= 1

def setNeighbours(x,y,maxx,maxy,vents,vent)
    if x > 0
        vent.addNeighbour vents[x-1][y]
    end
    if y > 0
        vent.addNeighbour vents[x][y-1]
    end
    if x < maxx
        vent.addNeighbour vents[x+1][y]
    end
    if y < maxy
        vent.addNeighbour vents[x][y+1]
    end
end

lowest = Array.new
notLowest = Array.new

vents.each_with_index {
    |row, i|
    row.each_with_index {
        |spot, j|
        setNeighbours(i,j,maxx,maxy,vents,spot)
        if spot.isLow
            lowest << spot
        else
            notLowest << spot
        end
    }
}

notLowest.each {
    |spot|
    target = spot.flowsInto
    vents[target[0]][target[1]].addFlow(spot)
}


sizes = Array.new
lowest.each {
    |low|
    sizes << low.getBasinSize
}
s = sizes.sort.reverse
puts s[0] * s[1] * s[2]