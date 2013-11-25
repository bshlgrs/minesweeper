class Tile

  attr_accessor :bomb, :pos

  def initialize(bomb, pos, parent)
    @bomb = bomb
    @pos = pos
    @parent = parent
    @flagged = false
    @revealed = false
    @display_char = "*"
  end

  def to_s
    @display_char
  end

  def flagged?
    @flagged
  end

  def revealed?
    @revealed
  end

  def is_bomb?
    @bomb
  end

  def inspect
    "tile (#{@pos}) bomb: #{@bomb}"
  end

  def reveal
    return if revealed? || flagged?
    @revealed = true

    if is_bomb?
      raise "bomb touched"
    end

    if neighbor_bomb_count == 0
      @display_char = "_"
      neighbors.each do |neighbor|
        next if neighbor.is_bomb? || neighbor.revealed?
        neighbor.reveal
      end
    else
      @display_char = neighbor_bomb_count.to_s
    end
  end

  def flag
    return if revealed?
    @display_char = "F"
    @flagged = true
  end

  def unflag
    @display_char = "*"
    @flagged = false
  end

  def get_tile_at(x, y)
    @parent[x, y]
  end

  def neighbors
    neighbors = []
    x,y = pos
    (y - 1..y + 1).each do |y|
      (x - 1..x + 1).each do |x|
        tile = get_tile_at(x, y)
        next if tile.nil?
        neighbors << tile unless tile == self
      end
    end
    neighbors
  end

  def neighbor_bomb_count
    neighbors.select(&:is_bomb?).length
  end
end