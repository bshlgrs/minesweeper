require "./tile.rb"
require "yaml"

class Board
  attr_accessor :mines_field

  def initialize(board_size, number_of_bombs)

    @board_size = board_size

    make_bombs(number_of_bombs)
    make_tiles
    @start_time = Time.now.to_i
  end

  def make_bombs(number_of_bombs)
    @bombed_tiles = []

    until @bombed_tiles.count == number_of_bombs
      new_bomb = [rand(@board_size), rand(@board_size)]
      @bombed_tiles << new_bomb unless @bombed_tiles.include? new_bomb
    end
  end

  def make_tiles
    @mines_field = []
    (0...@board_size).each do |row|
      new_row = []
      (0...@board_size).each do |column|
        new_row << Tile.new(@bombed_tiles.include?([column,row]),
                                                    [column,row],self)
      end
      @mines_field << new_row
    end
  end

  def show_board
    print "  "
    @mines_field.each_index do |index|
      print index % 10
    end
    puts
    puts
    @mines_field.each_with_index do |row,index|
      print "#{index % 10} "
      row.each do |tile|
        print tile
      end
      puts
    end
    puts
  end

  def reveal(pos)
    x, y = pos
    self[x, y].reveal
  end

  def flag(pos)
    x, y = pos
    self[x, y].flag
  end

  def unflag(pos)
    x, y = pos
    self[x, y].unflag
  end

  def [](x, y)
    return nil unless x >= 0 && y >= 0
    return nil unless x < @mines_field.length && y < @mines_field.length
    @mines_field[y][x]
  end

  def victory?
    (0...@board_size).each do |row|
      (0...@board_size).each do |column|
        tile = self[column, row]
        return false unless tile.flagged? == tile.is_bomb?
      end
    end
    true
  end

  def save(filename)
    @time_taken = Time.now.to_i - @start_time
    File.open(filename, "w") do |f|
      f.puts self.to_yaml
    end
  end

  def reload_time
    @start_time = Time.now.to_i - @time_taken
  end

  def time_taken
    Time.now.to_i - @start_time
  end

  def quit
    exit(0)
  end
end