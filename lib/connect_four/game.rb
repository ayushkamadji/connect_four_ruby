require 'connect_four/board'
require 'connect_four/rule'

class Game
  include Rule

  attr_reader :board, :active_player
  
  def initialize
    @board = Board.new
    @players = {p1: {name: "P1", mark: :red, next: :p2},
                p2: {name: "P2", mark: :yellow, next: :p1}}
    @active_player = @players[:p1]
  end

  def next_turn
    @active_player = @players[@active_player[:next]]
  end

  def process_move(column)
    @board.update(column, @active_player[:mark])
  end

  def over?
    has_winner? || is_stalemate?
  end

  def winner
    @players.values.find do |player|
      player[:mark] == win_mark
    end
  end
end
