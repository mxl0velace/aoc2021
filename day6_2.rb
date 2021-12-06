require './template.rb'
file_data = loadlines(6)

items = file_data[0].split(",")

fish = Array.new(9,0)
items.each {
    |item|
    i = item.to_i
    fish[i] += 1
}

256.times {
    birth = fish.shift
    fish.push(birth)
    fish[6] += birth
}

total = 0
fish.each{
    |f|
    total += f
}

puts total