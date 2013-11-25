require "./board.rb"

class Game
  def play(size = 9, bombs = 1)
    board = Board.new(size,bombs)

    until board.victory?
    #  begin
        board.show_board
        print ">> "
        board.instance_eval(gets.chomp)
     # rescue Exception => msg
        # if msg == "bomb touched"
    #       puts "You lose :("
    #       return
    #     else
    #       throw msg
    #     end
    #     #end
    end
    puts "You win :)"
  end
end

g = Game.new
g.play