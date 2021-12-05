require './template.rb'
file_data = loadlines(5)

class Line

    @@maxx = 0
    @@maxy = 0

    def initialize(text)
        splitOnce = text.split(" -> ")
        firstSplit = splitOnce[0].split(",")
        secondSplit = splitOnce[1].split(",")
        @x1 = firstSplit[0].to_i
        @y1 = firstSplit[1].to_i
        @x2 = secondSplit[0].to_i
        @y2 = secondSplit[1].to_i

        if @x1 > @@maxx
            @@maxx = @x1
        end
        if @x2 > @@maxx
            @@maxx = @x2
        end
        if @y1 > @@maxy
            @@maxy = @y1
        end
        if @y2 > @@maxy
            @@maxy = @y2
        end
    end

    attr_reader :x1
    attr_reader :x2
    attr_reader :y1
    attr_reader :y2
    
    def self.maxx
        @@maxx
    end

    def self.maxy
        @@maxy
    end

    def isDiagonal
        not (self.isVertical || self.isHorizontal)
    end

    def isHorizontal
        @y1 == @y2
    end
    def isVertical
        @x1 == @x2
    end

    def covers(x,y)
        dy = @y2 - @y1
        dx = @x2 - @x1
        d_y = @y2 - y
        d_x = @x2 - x
        gradCheck = false
        if dx == 0 && d_x == 0
            gradCheck = true
        elsif dx == 0 || d_x == 0
            gradCheck = false
        elsif self.isVertical
            gradCheck = @x1 == x
        elsif self.isHorizontal
            gradCheck = @y1 == y
        else
            gradCheck = (dy/dx) == (d_y/d_x)
            puts "This shouldn't be happening."
        end

        gradCheck && x <= [@x1, @x2].max && x >= [@x1, @x2].min && y <= [@y1, @y2].max && y >= [@y1, @y2].min
    end

    def coversRegion
        if self.isHorizontal
            toRet = Array.new
            r = @x1 < @x2 ? [*@x1..@x2] : [*@x2..@x1]
            r.each{
                |val|
                toRet.push([val, @y1])
            }
            return toRet
        elsif self.isVertical
            toRet = Array.new
            r = @y1 < @y2 ? [*@y1..@y2] : [*@y2..@y1]
            r.each{
                |val|
                toRet.push([@x1, val])
            }
            return toRet
        else
            return []
        end
    end
end

lines = Array.new
file_data.each {
    |line|
    lines.push(Line.new(line))
}

lines.each {
    |line|
    puts "Line : #{line.x1},#{line.y1} to #{line.x2},#{line.y2} - #{line.isDiagonal ? "diagonal" : "not diagonal"}"
}

hvlines = lines.select {
    |line|
    not line.isDiagonal
}

puts lines.length
puts hvlines.length

puts "maxx : #{Line.maxx}"
puts "maxy : #{Line.maxy}"

xs = [*0..Line.maxx]
ys = [*0..Line.maxy]


blankGrid = Array.new(Line.maxx) {Array.new(Line.maxy, 0)}

hvlines.each {
    |line|
    line.coversRegion.each {
        |point|
        x = point[0]
        y = point[1]
        blankGrid[x][y] += 1
    }
}

bg = blankGrid.flatten
fg = bg.select {
    |v|
    v >= 2
}

puts fg.length