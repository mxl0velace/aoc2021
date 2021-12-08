require "./template.rb"
file_data = loadlines(8)

after = Array.new
file_data.each {
    |line|
    after << line.split("|")[1].split()
}

total = 0

after.each{
    |line|
    line.each {
        |seg|
        if [2,3,4,7].include? seg.length 
            total += 1
        end
    }
}

puts total