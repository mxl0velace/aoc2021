require "./template.rb"
file_data = loadlines(10)

bracket = {"(" => ")", "[" => "]", "{" => "}", "<" => ">"}
points = {")" => 3, "]" => 57, "}" => 1197, ">" => 25137}


total = 0

file_data.each {
    |line|
    stack = []
    line.each_char {
        |c|
        if bracket.keys.include? c
            stack << c
        else
            last = stack.pop
            if c != bracket[last]
                puts "Invalid character #{c}"
                total += points[c]
                break
            end
        end
    }
}

puts total