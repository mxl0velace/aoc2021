require 'mechanize'
def main
    agent = Mechanize.new
    agent.cookie_jar.load("cookies.txt", :cookiestxt)
    file = agent.get("https://adventofcode.com/2021/day/2/input").body
    file_data = file.split("\n")
    hor = 0
    ver = 0

    file_data.each {
        |line|
        ls = line.split(" ")
        case ls[0]
        when "forward"
            hor += ls[1].to_i
        when "down"
            ver += ls[1].to_i
        when "up"
            ver -= ls[1].to_i
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