class Board
  HEIGHT = 6
  WIDTH = 7

  attr_reader :nodes

  def initialize
    @nodes = Array.new(WIDTH) do
      |i| Array.new(HEIGHT) {:blank}
    end
  end
  
  def update(column, value)
    @nodes[column][blank_index(column)] = value 
  end

  def full?
    @nodes.all? do |col| 
      col.all? { |node| node != :blank } 
    end
  end


  private

  def blank_index(column)
    @nodes[column].index(:blank)
  end
end
