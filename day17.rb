require "./template.rb"
file_data = ["target area: x=20..30, y=-10..-5"]
file_data = loadlines(17)
file_format = /x=(-?\d+)\.\.(-?\d+), y=(-?\d+)\.\.(-?\d+)/

def applyDrag(velocity)
    if velocity[0] != 0
        velocity[0] += (0-velocity[0].abs)/velocity[0]
    end
    velocity[1] -= 1 
end

def addVelocity(position, velocity)
    position[0] += velocity[0]
    position[1] += velocity[1]
end

def withinBounds(position, minx, maxx, miny, maxy)
    return position[0] >= minx && position[0] <= maxx && position[1] >= miny && position[1] <= maxy
end

def calcXSteps(minx, maxx)
    ns = (1..maxx + 1)
    options = []
    ns.each {
        |n|
        tn = n
        total = 0
        while total < maxx && tn > 0
            total += tn
            if total <= maxx && total >= minx
                options << n
                break
            end
            tn -= 1
        end
    }
    return options
end

def runSim(x,y,minx, maxx, miny, maxy)
    position = [0,0]
    velocity = [x,y]
    top = 0
    scored = false
    while position[1] > miny
        top = [position[1], top].max
        addVelocity(position, velocity)
        applyDrag(velocity)
        if withinBounds(position, minx, maxx, miny, maxy)
            #puts "Score, maxy #{top} with #{x}, #{y}"
            return top
            break
        end
    end
    return -1
end

def detailedSim(x,y, minx, maxx, miny, maxy)
    position = [0,0]
    velocity = [x,y]
    maxy = 0
    scored = false
    while position[1] > miny
        maxy = [position[1], maxy].max
        addVelocity(position, velocity)
        applyDrag(velocity)
        puts "Position: #{position}, Velocity: #{velocity}"
        if withinBounds(position, minx, maxx, miny, maxy)
            puts "Within bounds: #{position}"
            puts "Score, maxy #{maxy} with #{x}, #{y}"
            return maxy
            break
        end
    end
    return -1
end

ys = (1..1000)

m = file_data[0].match(file_format)
minx = m[1].to_i
maxx = m[2].to_i
tminy = m[3].to_i
tmaxy = m[4].to_i
miny = [tminy, tmaxy].min
maxy = [tminy, tmaxy].max

xs = calcXSteps(minx, maxx)


peak = -1
xs.each {
    |x|
    ys.each {
        |y|
        val = runSim(x,y,minx,maxx,miny,maxy)
        if val > peak
            peak = val
            puts "New max: #{peak}"
        end
    }
} 


puts peak
#detailedSim(7,30,minx,maxx,miny,maxy)