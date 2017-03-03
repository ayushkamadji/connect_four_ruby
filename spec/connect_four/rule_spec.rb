describe Rule do
  let(:object) { Game.new }
  let(:board) { object.board }

  describe "#node_lines" do
    it "returns an array of arrays of node lines to be assesed" do
      (1..7).each do |col|
        (1..6).each do |val|
          board.update(col-1, val+((col-1)*6))
        end
      end

      expect(object.node_lines).to eql(
        object.columns + object.rows + object.diagonals
      )
    end
  end

  describe "#columns" do
    it "returns an array of arrays of node lines in columns" do
      expect(object.columns).to eql(board.nodes)
    end
  end

  describe "#rows" do
    it "returns an array of arrays of node lines in rows" do
      expect(object.rows).to eql(
        board.nodes.transpose)
    end
  end

  describe "#diagonals" do
    it "returns an array of arrays of node lines in diagonals with 3 < size < 7" do
      (1..7).each do |col|
        (1..6).each do |val|
          board.update(col-1, val+((col-1)*6))
        end
      end

      expect(object.diagonals).to eql(
        [ [19, 26, 33, 40],
          [13, 20, 27, 34, 41],
          [7, 14, 21, 28, 35, 42],
          [1, 8, 15, 22, 29, 36],
          [2, 9, 16, 23, 30],
          [3, 10, 17, 24],

          [4, 9, 14, 19],
          [5, 10, 15, 20, 25],
          [6, 11, 16, 21, 26, 31],
          [12, 17, 22, 27, 32, 37],
          [18, 23, 28, 33, 38],
          [24, 29, 34, 39]
        ]
      )
    end
  end

  describe "#win_mark" do
    context "game has no winner" do
      it "returns nil" do
        expect(object.win_mark).to eql(nil)
      end
    end

    context ":yellow wins in diagonal (1,1)-(4,4)" do
      it "returns :yellow" do
        object.board.update(1, :red)
        object.board.update(1, :yellow)
        2.times { object.board.update(2, :red) }
        object.board.update(2, :yellow)
        3.times { object.board.update(3, :red) }
        object.board.update(3, :yellow)
        object.board.update(4, :yellow)
        3.times { object.board.update(4, :red) }
        object.board.update(4, :yellow)

        expect(object.win_mark).to eql(:yellow)
      end
    end

    context ":red wins in row 0" do
      it "returns :red" do
        object.board.update(2, :red)
        object.board.update(4, :red)
        object.board.update(5, :red)
        object.board.update(3, :red)

        expect(object.win_mark).to eql(:red)
      end
    end
  end

  describe "#has_winner?" do
    context "game has no winner" do
      it "returns false" do
        expect(object.has_winner?).to eql(false)
      end
    end

    context "game has winner" do
      it "returns true" do
        object.board.update(2, :red)
        object.board.update(4, :red)
        object.board.update(5, :red)
        object.board.update(3, :red)

        expect(object.has_winner?).to eql(true)
      end
    end
  end

  describe "#is_stalemate?" do
    context "board not full and no winner yet" do
      it "returns false" do
        expect(object.is_stalemate?).to eql(false)
      end
    end

    context "board is full and no winner" do
      it "returns true" do
        object.board.nodes.each do |col|
          col.each { |node| node = :not_blank }
        end

        expect(object.is_stalemate?).to eql(false)
      end
    end
  end
end
