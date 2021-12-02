require './template.rb'
def main
    file_data = loadlines(2)
    hor = 0
    ver = 0
    aim = 0

    file_data.each {
        |line|
        ls = line.split(" ")
        case ls[0]
        when "forward"
            hor += ls[1].to_i
            ver += ls[1].to_i * aim
        when "down"
            aim += ls[1].to_i
        when "up"
            aim -= ls[1].to_i
        else
            puts "Error!"
        end
    }

    puts "Hor = #{hor}"
    puts "Ver = #{ver}"
    puts "Multiplied = #{hor*ver}"
end

if __FILE__ == $0
    main
end