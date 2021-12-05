require './template.rb'
file_data = loadlines(4)
$gameOver = false


class Row
    def initialize(nums)
        @nums = nums
    end

    def mark(val)
        @nums.delete(val)
        return @nums.length() == 0
    end
end

def genRows(board)
    length = board.length()
    n = 0
    rows = Array.new
    while n < length
        rows << Row.new(board[n..n+4])
        n += 5
    end
    return rows
end

def genCols(board)
    length = board.length() / 5
    n = 0
    cols = Array.new
    while n < length
        cols << Row.new([board[n], board[n+5], board[n+(5*2)], board[n+(5*3)], board[n+(5*4)]])
        n += 1
    end
    return cols
end

class BingoBoard
    def initialize(board)
        @board = board
        @rows = genRows(board)
        @cols = genCols(board)
        @permaboard = board
    end

    def mark(num)
        @board.delete(num)
        @rows.each{
            |row|
            if row.mark(num)
                self.win(num)
            end
        }

        @cols.each{
            |col|
            if col.mark(num)
                self.win(num)
            end
        }
    end

    def win(num)
        puts @permaboard
        total = 0
        @board.each{
            |val|
            total += val
        }
        puts total * num
        $gameOver = true
    end
end

bingoList = file_data.shift
bList = Array.new
bingoList.split(",").each{
    |item|
    iitem = item.to_i
    bList << iitem 
}

len = file_data.length()
n = 0
allBoards = Array.new

while n < len
    b = Array.new
    file_data[n+1..n+5].each {
        |line|
        ls = line.split
        ls.each {
            |item|
            b << item.to_i
        }
    }
    allBoards << BingoBoard.new(b)
    n += 6
end

puts allBoards

n = 0

while not $gameOver
    puts "Marking #{bList[n]}"
    allBoards.each{
        |board|
        board.mark(bList[n])
    }
    n += 1
end