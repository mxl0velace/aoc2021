require "./template.rb"
file_data = loadlines(15)

$endx = file_data[0].length - 1
$endy = file_data.length - 1
$cost = Array.new

def h(x, y)
    return ($endx - x) + ($endy - y)
end

def f(y, x)
    return $cost[y][x] + h(x,y)
end

def lowest(list)
    low = list[0]
    list.each {
        |item|
        if f(low[0], low[1]) > f(item[0], item[1])
            low = item
        end
    }
    return low
end

risk = Array.new
toSearch = Array.new
searched = Hash.new

file_data.each {
    |line|
    l = Array.new
    l2 = Array.new
    line.split("").each {
        |c|
        l << c.to_i
        l2 << 999
    }
    risk << l
    $cost << l2
}

$cost[0][0] = 0
toSearch << [0,0]

def findOut(current, neighbour, searched, risk, toSearch)
    if not searched.include? neighbour
        if toSearch.include? neighbour
            if $cost[neighbour[0]][neighbour[1]] > searched[current] + risk[neighbour[0]][neighbour[1]]
                $cost[neighbour[0]][neighbour[1]] = searched[current] + risk[neighbour[0]][neighbour[1]]
            end
        else
            toSearch << neighbour
            $cost[neighbour[0]][neighbour[1]] = searched[current] + risk[neighbour[0]][neighbour[1]]
        end
    end
end

while not searched.include? [$endy, $endx]
    current = lowest(toSearch)
    toSearch.delete current
    searched[current] = $cost[current[0]][current[1]]
    puts "Final cost to get to #{current} is #{searched[current]} (aiming for #{$endy}, #{$endx})"
    if current[0] != 0
        findOut(current, [current[0] - 1, current[1]], searched, risk, toSearch)
    end
    if current[0] != $endy
        findOut(current, [current[0] + 1, current[1]], searched, risk, toSearch)
    end
    if current[1] != 0
        findOut(current, [current[0], current[1] - 1], searched, risk, toSearch)
    end
    if current[1] != $endx
        findOut(current, [current[0], current[1] + 1], searched, risk, toSearch)
    end
end

puts "done: #{searched[[$endy, $endx]]}"