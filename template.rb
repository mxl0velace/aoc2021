require 'mechanize'
def load(day)
    agent = Mechanize.new
    agent.cookie_jar.load("cookies.txt", :cookiestxt)
    return agent.get("https://adventofcode.com/2021/day/#{day}/input").body
end

def loadlines(day)
    return load(day).split("\n")
end

def loadlines_offline(day)
    return File.open("day#{day}.txt").readlines.map(&:chomp)
end