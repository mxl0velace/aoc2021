require './template.rb'
file_data = loadlines(7)

crabs = Array.new
maxcrab = 0
mincrab = 9999999999

file_data[0].split(",").each {
    |line|
    c = line.to_i
    maxcrab = c if c > maxcrab
    mincrab = c if c < mincrab
    crabs.push(c)
}

r = mincrab..maxcrab
maxtotal = 99999999
maxr = -1

r.each {
    |pos|
    total = 0
    crabs.each {
        |crab|
        diff = (crab - pos).abs
        total += (diff * (diff + 1))/2
    }
    puts "Trying #{pos} : #{total}"
    if total < maxtotal
        maxtotal = total
        maxr = pos
    end
}

puts maxr
puts maxtotal