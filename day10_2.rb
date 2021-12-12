require "./template.rb"
file_data = loadlines(10)

bracket = {"(" => ")", "[" => "]", "{" => "}", "<" => ">"}
points = {")" => 3, "]" => 57, "}" => 1197, ">" => 25137, "(" => 1, "[" => 2, "{" => 3, "<" => 4}


totals = Array.new

file_data.each {
    |line|
    stack = []
    corrupted = false
    line.each_char {
        |c|
        if bracket.keys.include? c
            stack << c
        else
            last = stack.pop
            if c != bracket[last]
                corrupted = true
                break
            end
        end
    }

    linetotal = 0

    if not corrupted
        stack.reverse.each {
            |start|
            print(start)
            linetotal *= 5
            linetotal += points[start]
        }
        totals << linetotal
        puts " #{linetotal}"
    end
}

puts totals.sort[(totals.length - 1) / 2]