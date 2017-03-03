describe Board do
  let(:board) { Board.new }
  
  describe "#initialize" do 
    it "creates a 7 x 6 Array of Array" do
      expect(board.nodes.size).to eql(7)
      expect(board.nodes.all? { |a| a.size == 6 }).to be true
    end
  end

  describe "#update" do
    before do
      board.update(0, :red)
      board.update(3, :yellow)
      board.update(2, :red)
      board.update(2, :yellow)
      board.update(4, :red)
    end

    context "with (0, :red)" do
      it "changes column 0 at index of first :blank element to :red" do
        board.update(0, :red)
        expect(board.nodes[0].rindex(:red)).to eql(1)
        expect(board.nodes[0][1]).to eql(:red)
      end
    end

    context "with (4, :yellow)" do
      it "changes column 4 at index of first :blank element to :yellow" do
        board.update(4, :yellow)
        expect(board.nodes[4].rindex(:yellow)).to eql(1)
        expect(board.nodes[4][1]).to eql(:yellow)
      end
    end
  end

  describe "#full?" do
    context "board is not full" do
      it "returns false" do
        expect(board.full?).to eql(false)
      end
    end

    context "board is full" do
      it "returns true" do
        board.nodes.each do |col| 
          col.collect! { |node| node = :not_blank } 
        end

        expect(board.full?).to eql(true)
      end
    end
  end
end
