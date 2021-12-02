require 'mechanize'
def main
    agent = Mechanize.new
    agent.cookie_jar.load("cookies.txt", :cookiestxt)
    file = agent.get("https://adventofcode.com/2021/day/1/input").body
    file_data = file.split("\n")

    puts file_data
end

if __FILE__ == $0
    main
end