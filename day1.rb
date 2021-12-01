def main
    file = File.open("day1.txt")
    file_data = file.readlines.map(&:chomp)
    total = 0
    for i in (1..file_data.length()) do
        if file_data[i].to_i > file_data[i-1].to_i
            total += 1
        end
    end
    puts total
end

if __FILE__ == $0
    main
end