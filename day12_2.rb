require './template.rb'
file_data = loadlines(12)

class Cave
    def initialize(name)
        @name = name
        @connections = Array.new
        @visited = false
    end

    def visit(visited)
        if not @visited
            @visited = true
            puts "Visited #{@name}"
        end
    end

    def makeConnection(target)
        @connections << target
    end

    def reset
        @visited = false
    end

    def isEnd
        return @name == "end"
    end

    def isStart
        return @name == "start"
    end

    def getConnections
        return @connections
    end

    def isBig
        return false
    end

    def getName
        return @name
    end

end

class BigCave < Cave
    def visit(visted)
        super
        visited = false
    end

    def isBig
        return true
    end
end

def exploreFrom(cave, visited, smallDupe)
    if cave.isEnd
        return 1
    else
        totalPaths = 0
        cave.getConnections.each {
            |nextCave|
            if nextCave.isStart
            else
                v = visited.dup
                v << cave
                if nextCave.isBig or not visited.include? nextCave
                    totalPaths += exploreFrom(nextCave, v, smallDupe)
                elsif smallDupe
                    totalPaths += exploreFrom(nextCave, v, false)
                end
            end
        }
        return totalPaths
    end
end

caves = {"start" => Cave.new("start"), "end" => Cave.new("end")}

file_data.each {
    |line|
    l = line.split("-")
    if not caves.keys.include? l[0]
        if l[0] == l[0].upcase
            caves[l[0]] = BigCave.new(l[0])
        else
            caves[l[0]] = Cave.new(l[0])
        end
    end
    if not caves.keys.include? l[1]
        if l[1] == l[1].upcase
            caves[l[1]] = BigCave.new(l[1])
        else
            caves[l[1]] = Cave.new(l[1])
        end
    end

    caves[l[0]].makeConnection(caves[l[1]])
    caves[l[1]].makeConnection(caves[l[0]])
}

puts exploreFrom(caves["start"], [], true)