require "./board.rb"
require "yaml"
require "debugger"

class Game
  def play(size = 5, bombs = 1)
    board = get_board(size,bombs)

    until board.victory?
      begin
        system 'clear'
        board.show_board
        print ">> "

        input = $stdin.gets.chomp
        board.instance_eval(input)
      rescue RuntimeError => msg
        if msg.message == "bomb touched"
          puts "You lose :("
          return
        else
          p msg
        end
      end
    end

    victory_message(board)
  end
end

def get_board(size, bombs)
  if ARGV.empty?
    Board.new(size,bombs)
  else
    board = YAML::load_file(ARGV.first)
    board.reload_time
    board
  end
end

def victory_message(board)
  time_taken = board.time_taken
  high_scores = YAML::load_file("high_scores")
  high_scores << time_taken
  high_scores = high_scores.sort.take(10)

  puts "You win :)"
  puts "You took #{time_taken} seconds."
  puts "Best times:"
  puts high_scores

  File.open("high_scores", "w") do |f|
    f.puts high_scores.to_yaml
  end
end

g = Game.new
g.play