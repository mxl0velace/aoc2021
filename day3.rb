require './template.rb'
file_data = loadlines(3)

stores = Array.new(file_data[0].length, 0)

file_data.each {
    |line|
    line.split('').each_with_index {
        |val, i|
        if val == "1"
            stores[i] += 1
        else
            stores[i] -= 1
        end
    }
}

stores = stores.reverse()
gamma = 0
epsilon = 0
pow = 1
stores.each {
    |val|
    tpow = val > 0 ? pow : 0
    vpow = val > 0 ? 0 : pow
    gamma += tpow
    epsilon += vpow
    pow *= 2
}

puts "Gamma = #{gamma}"
puts "Epsilon = #{epsilon}"
puts "Mult = #{gamma * epsilon}"