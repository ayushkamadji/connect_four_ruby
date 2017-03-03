describe Game do
  let(:game) { Game.new }

  describe "#next_turn" do
    context "@active_player is @p1" do
      it "changes @active_player to @p2" do
        game.next_turn

        expect(game.
               instance_variable_get(:@active_player)
              ).to eql(
              game.
              instance_variable_get(:@players)[:p2])
      end
    end
  end

  describe "#process_move" do
    context "@active_player's mark is :red" do
      context "with column 0" do
        it "updates board with :red at the last position of column 0" do
          game.process_move(0)
          expect(game.board.nodes[0][0]).to eql(:red)
        end
      end
    end
  end

  describe "#over?" do
    context "game is not over" do
      it "returns false" do
        expect(game.over?).to eql(false)
      end
    end

    context "game is stalemate" do
      it "returns true" do
        game.board.nodes.each do |col|
          col.collect! { |node| node = :not_blank }
        end
        
        expect(game.over?).to eql(true)
      end
    end

    context "game has winner" do
      it "returns true" do
        game.process_move(3)
        game.process_move(4)
        game.process_move(5)
        game.process_move(6)

        expect(game.over?).to eql(true)
      end
    end
  end

  describe "#winner" do
    context "when the winning mark is red" do
      it "returns player[:p1]" do
        game.process_move(3)
        game.process_move(4)
        game.process_move(5)
        game.process_move(6)

        expect(game.winner).to eql(
          game.instance_variable_get(:@players)[:p1]
        )
      end
    end

    context "when the winning mark is yellow" do
      it "returns player[:p2]" do
        game.next_turn
        game.process_move(3)
        game.process_move(4)
        game.process_move(5)
        game.process_move(6)

        expect(game.winner).to eql(
          game.instance_variable_get(:@players)[:p2]
        )
      end
    end
  end
end
