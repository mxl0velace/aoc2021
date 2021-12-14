require "./template.rb"
file_data = loadlines(13)

points = Array.new
folds = Array.new

file_data.each {
    |line|
    if line == ""
    elsif line[0] == "f"
        l = line.split("=")
        dir = l[0][-1]
        val = l[1].to_i
        folds << [dir, val]
    else
        point = line.split(",")
        points << [point[0].to_i, point[1].to_i]
    end
}

folds.each {
    |fold|
    if fold[0] == "y"
        points.each {
            |point|
            if point[1] > fold[1]
                point[1] = (2 * fold[1]) - point[1]
            end
        }
    else
        points.each {
            |point|
            if point[0] > fold[1]
                point[0] = (2 * fold[1]) - point[0]
            end
        }
    end
    puts "total = #{points.length}, unqiue = #{points.uniq.length}"
}

un = points.uniq

print un
puts ""
xs = (0..50)
ys = (0..50)

xs.each {
    |y|
    ys.each {
        |x|
        if un.include? [x, y]
            print "#"
        else
            print "."
        end
    }
    puts ""
}