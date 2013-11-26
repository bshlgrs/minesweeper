$high_scores = []

require "./board.rb"
require "yaml"
require "debugger"

class Game
  def play(size = 9, bombs = 10)
    board = get_board(size,bombs)

    until board.victory?
      system 'clear'
      board.show_board
      char = ""
      begin
        system("stty raw -echo")
        char = STDIN.getc
      ensure
        system("stty -raw echo")
      end

      begin
        case char
        when "w"
          board.up
        when "a"
          board.left
        when "s"
          board.down
        when "d"
          board.right
        when "f"
          board.flag
        when " "
          board.reveal
        end


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

  $high_scores << time_taken
  $high_scores = $high_scores.sort.take(10)

  puts "You win :)"
  puts "You took #{time_taken} seconds."
  puts "Best times:"
  puts $high_scores

  this_code = File.readlines("game.rb")
  this_code.shift
  this_code.unshift("$high_scores = #{$high_scores.inspect}\n")

  File.open("game.rb", "w") do |f|
    f.puts(this_code.join(""))
  end
end

g = Game.new
g.play
