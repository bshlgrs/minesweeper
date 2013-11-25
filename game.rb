require "./board.rb"

class Game
  def play(size = 9, bombs = 20)
    board = Board.new(size,bombs)

    until board.victory?
      begin
        system 'clear'
        board.show_board
        print ">> "
        board.instance_eval(gets.chomp)
      rescue RuntimeError => msg
        if msg.message == "bomb touched"
          puts "You lose :("
          return
        else
          p msg
        end
      end
    end
    puts "You win :)"
  end
end

g = Game.new
g.play