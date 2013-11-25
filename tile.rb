class Tile

  attr_accessor :bomb, :pos

  def initialize(bomb, pos, parent)
    @bomb = bomb
    @pos = pos
    @parent = parent
    @flagged = false
    @revealed = false
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

  def reveal
    @revealed = true
  end

  def get_tile_at(x,y)
    parent[y][x] rescue nil
  end

  def neighbors
    neighbors = []
    x,y = pos
    (y - 1..y + 1).each do |y|
      (x - 1..x + 1).each do |x|
        tile = get_tile_at(x, y)
        next if tile.nil?
        neighbor << tile unless tile == self
      end
    end
    neighbors
  end

  def neighbor_bomb_count
    neighbors.select(&:is_bomb?).length
  end

end