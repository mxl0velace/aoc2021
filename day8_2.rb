require "./template.rb"
file_data = loadlines(8)

vals = Array.new
file_data.each {
    |line|
    l = line.split("|")
    v0 = l[0].split()
    v1 = l[1].split()
    vals << [v0,v1]
}

total = 0

lightmaps = {"abcefg" => 0, "cf" => 1, "acdeg" => 2, "acdfg" => 3, "bcdf" => 4, "abdfg" => 5, "abdefg" => 6, "acf" => 7, "abcdefg" => 8, "abcdfg" => 9}

vals.each{
    |line|
    counts = Hash.new(0)
    cseven = ""
    cone = ""
    cfour = ""
    mapping = {"a" => "", "b" => "", "c" => "", "d" => "", "e" => "", "f" => "", "g" => "",}
    line[0].each {
        |word|
        if word.length == 2
            cone = word
        elsif word.length == 3
            cseven = word
        elsif word.length == 4
            cfour = word
        end
        word.each_char {
            |c|
            counts[c] += 1
        }
    }
    # Stage 0 - frequencies
    mapping["f"] = counts.key(9)
    mapping["e"] = counts.key(4)
    mapping["b"] = counts.key(6)
    # Stage 1 - number eliminations 1
    cone.each_char {
        |c|
        if not mapping.value? c
            mapping["c"] = c
            break
        end
    }
    # Stage 2 - number eliminations 2
    cseven.each_char {
        |c|
        if not mapping.value? c
            mapping["a"] = c
            break
        end
    }
    cfour.each_char {
        |c|
        if not mapping.value? c
            mapping["d"] = c
            break
        end
    }
    # Stage 3 - last value
    teststring = "abcdefg"
    teststring.each_char {
        |c|
        if not mapping.value? c
            mapping["g"] = c
            break
        end
    }
    puts mapping
    afterval = 0
    line[1].each_with_index {
        |val, i|
        rval = val.chars
        rval.each_with_index {
            |v, j|
            rval[j] = mapping.key(v)
        }
        sorted = rval.sort.join
        afterval += (10 ** (3-i)) * lightmaps[sorted]
    }
    puts afterval
    total += afterval
}

puts total