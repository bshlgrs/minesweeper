require "./tile.rb"

class Board
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
        new_row << Tile.new(bombed_squares.include?([row, column]),
                                                    [row,column],self)
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
  end
end

b = Board.new(9,10)
b.show_board