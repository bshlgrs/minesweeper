require "./tile.rb"

class Board
  attr_accessor :mines_field

  def initialize(board_size, number_of_bombs)

    bombed_squares = []

    until bombed_squares.count == number_of_bombs
      new_bomb = [rand(board_size), rand(board_size)]
      bombed_squares << new_bomb unless bombed_squares.include? new_bomb
    end

    @mines_field = []
    (0...board_size).each do |row|
      new_row = []
      (0...board_size).each do |column|
        new_row << Tile.new(bombed_squares.include?([column,row]),
                                                    [column,row],self)
      end
      @mines_field << new_row
    end
  end

  def show_board
    @mines_field.each do |row|
      row.each do |tile|
        print tile.show
      end
      puts
    end
    puts
  end

  def reveal(pos)
    x,y = pos
    @mines_field[y][x].reveal
  end

  def [](x, y)
    return nil unless x >= 0 && y >= 0
    return nil unless x < @mines_field.length && y < @mines_field.length
    @mines_field[y][x]
  end
end

b = Board.new(9,5)
b.show_board

while true
  x,y = eval("[#{gets.chomp}]")
  b.reveal([x,y])
  b.show_board
end