require './template.rb'
file_data = loadlines(3)

stores = Array.new(file_data[0].length, 0)

def most_common_bit(array, index)
    count = 0
    array.each{
        |val|
        if val[index] == "1"
            count += 1
        else
            count -= 1
        end
    }
    return count >= 0 ? "1" : "0"
end

def most_least(array, index)
    mcb = most_common_bit(array, index)
    puts "Most common bit: #{mcb}"
    return array.partition{
        |val|
        val[index] == mcb
    }
end

mostlist = file_data
leastlist = file_data

stores.each_with_index{
    |v, i|
    mostlist = most_least(mostlist, i)[0]
    puts "mostlist: #{mostlist.length()}"
    leastlist = most_least(leastlist, i)[1]
    puts "leastlist: #{leastlist.length()}"
    if leastlist.length == 1
        puts leastlist
    end
}

puts "MCB: #{mostlist}"
puts "LCB: #{leastlist}"