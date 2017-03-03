require 'connect_four/game'


def clear
  print "\e[2J\e[1;1H"
end

def display_mark(node)
  case node
  when :blank then return "\e[0;30m\e[1;44m\u2B24"
  when :yellow then return "\e[0;33m\e[1;44m\u2B24"
  when :red then return "\e[0;31m\e[1;44m\u2B24"
  end
end

def display_player(player)
  mark = player[:mark]

  case mark
  when :red then return "\e[1;30m\e[41m #{player[:name]} "
  when :yellow then return "\e[1;30m\e[43m #{player[:name]} "
  end
end

def display_game(game)
  clear
  rows = game.board.nodes.transpose

  print "\n\t  0   1   2   3   4   5   6"
  print "\n"

  rows.reverse_each do |row|
    print "\n\t\e[1;44m "
    row.each do |node|
      print " #{display_mark(node)}  "
    end
    print " \e[0m"
    print "\n\t\e[1;44m                              \e[0m"
  end
  print "\n"

  print "\n\t#{display_player(game.active_player)}\e[0m"
  print "\n"
end

def display_menu
  clear
  print "\n"
  print "\t============\n"
  print "\tCONNECT FOUR\n"
  print "\t============\n"
  print "\n"
  print "\tPress Any Key to Start\n"
  print "\t"
end

def display_game_over(game)
  clear
  print "\n"
  print "\n"
  print "\t\tGAME OVER\n"
  print "\n"
  print "\n"

  if game.has_winner?
    print "\t\t#{game.winner[:name]} WINS!\n"
  elsif game.is_stalemate?
    print "\t\tSTALEMATE\n"
  end
  print "\t"
end

def prompt
  print "\n\tYour move? (0 - 6)\n"
  print "\t"
  gets.strip.to_i
end

def start(game)
  until game.over?
  display_game(game)
  game.process_move(prompt)
  game.next_turn
  end
end

def start_app
  display_menu
  gets

  no_rematch = false

  until no_rematch
  game = Game.new
  start(game)

  display_game_over(game)
  gets
  
  unless rematch?
    no_rematch = true
    clear
    print "\n"
    print "\n\t\tSEE YA!\n\t"
    gets
    clear
  end
  end
end

def rematch?
  clear
  print "\n"
  print "\n\tWould you like a rematch? (y/n)"
  print "\n\t"
  gets.strip == 'y'
end
