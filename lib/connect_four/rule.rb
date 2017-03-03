module Rule
  
  def node_lines
    columns + rows + diagonals
  end

  def columns
    board.nodes
  end

  def rows
    board.nodes.transpose
  end

  def diagonals
    result = []

    result += diagonal(board.nodes, :forward)     
    result += diagonal(board.nodes, :reverse)     
    
    result.select { |a| a.size >= 4 }
  end

  def diagonal(arr, direction)
    padded = []
    pad = (direction == :forward ? arr.size-1 : 0)

    arr.each do |col|
      r_pad = arr.size - 1 - pad

      padded << (([nil] * pad) + col + ([nil] * r_pad))
      pad += (direction == :forward ? -1 : 1)
    end

    padded.transpose.map(&:compact)
  end

  def win_mark
    return :yellow if wins(:yellow)
    return :red if wins(:red)
    return nil 
  end

  def wins(mark)
    node_lines.any? do |line|
      line.each_cons(4).any? do |nodes|
        nodes.all? { |node| node == mark }
      end
    end
  end

  def has_winner?
    !(win_mark == nil)
  end

  def is_stalemate?
    board.full? && !has_winner?
  end
end
