require './template.rb'
file_data = loadlines(14)

polymer = file_data[0]
instructions = Hash.new
pairs = Hash.new(0)


file_data.shift
file_data.shift

file_data.each {
    |line|
    l = line.split(" -> ")
    instructions[l[0].split("")] = l[1]
}

polymer.split("").each_with_index {
    |v, i|
    if i < polymer.length - 1
        vals = [v, polymer[i+1]]
        pairs[vals] += 1
    end
}

puts "#{instructions}"
puts "#{pairs}"

def pair_step(pairs, instr)
    newhash = Hash.new(0)
    pairs.each {
        |k, v|
        if instr.include? k
            middle = instr[k]
            pair1 = [k[0], middle]
            pair2 = [middle, k[1]]
            newhash[pair1] += v
            newhash[pair2] += v
        else
            puts "Not found: #{k}"
            newhash[k] += v
        end
    }
    return newhash
end

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
40.times {
    puts "step #{n}"
    pairs = pair_step(pairs, instructions)
    n += 1
}

puts pairs

freq = Hash.new(0)

pairs.each {
    |k, v|
    freq[k[0]] += v
    freq[k[1]] += v
}

freq[polymer[0]] += 1
freq[polymer[-1]] += 1

puts "#{freq}"
biggest = freq.max_by {|k,v| v}
smallest = freq.min_by {|k,v| v}

puts "ANSWER: #{(biggest[1] - smallest[1]) / 2}"