require 'mechanize'
def main
    agent = Mechanize.new
    agent.cookie_jar.load("cookies.txt", :cookiestxt)
    file = agent.get("https://adventofcode.com/2021/day/1/input").body
    #puts file.body
    #file = File.open("day1.txt")
    file_data = file.split("\n")
    total = 0
    for i in (3..file_data.length()) do
        if file_data[i].to_i > file_data[i-3].to_i
            total += 1
        end
    end
    puts total
end

if __FILE__ == $0
    main
end