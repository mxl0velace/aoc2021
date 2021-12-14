require './template.rb'
file_data = loadlines(14)

polymer = file_data[0]
instructions = Array.new

file_data.shift
file_data.shift

file_data.each {
    |line|
    l = line.split(" -> ")
    instructions << l
}

def step(poly, instr)
    toUpdate = Array.new
    poly.split("").each_with_index {
        |val, i|
        if i < poly.length - 1
            vals = [val, poly[i+1]]
            instr.each {
                |inspair|
                if vals == inspair[0].split("")
                    toUpdate << [i, inspair[1]]
                end
            }
        end
    }

    toUpdate = toUpdate.sort {|a,b| a[0] <=> b[0]}
    toUpdate = toUpdate.reverse

    toUpdate.each {
        |ind, val|
        poly.insert(ind+1, val)
    }
end

n = 0
10.times {
    puts "step #{n}"
    step(polymer, instructions)
    n += 1
}

puts polymer

freq = polymer.split("").inject(Hash.new(0)) { |h,v| h[v] += 1; h }
print freq
biggest = freq.max_by {|k,v| v}
smallest = freq.min_by {|k,v| v}

print biggest[1] - smallest[1]