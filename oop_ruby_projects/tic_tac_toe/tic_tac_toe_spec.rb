require './tic_tac_toe.rb'
require 'rspec'

describe "Tic Tac Toe" do 
	before { @game = Game.new }

	describe "Game" do
		subject { @game }
		it { should respond_to(:players) } 
		it { should respond_to(:board) }
		it { should respond_to(:mark) }
		it { should respond_to(:game_over?) }
		it { should respond_to(:winner) }
		it { should respond_to(:display_board) }
		its(:board){ should == [[" "," "," "],[" "," "," "],[" "," "," "]] }

		describe "mark" do
			before { @game.mark(1,1,@game.players[1]) }
			its(:board) { should == [[" "," "," "],[" ","X"," "],[" "," "," "]] }
		end
	end

	describe "Player" do
		before { @player = Player.new("O") }
		subject { @player }
		it { should respond_to(:symbol) }
		its(:symbol) { should == "O" }
	end
end