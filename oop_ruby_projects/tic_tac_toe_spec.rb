require './tic_tac_toe.rb'
require 'rspec'

describe "Tic Tac Toe" do 
	describe "Game" do
		before { @game = Game.new }

		subject { @game }
		it { should respond_to(:players) } 
		it { should respond_to(:board) }
		it { should respond_to(:game_over?) }
		it { should respond_to(:winner) }
	end

	describe "Board" do
		before { @board = Board.new }

		subject { @board }
		it { should respond_to(:mark) }
		it { should respond_to(:print) }
		it { should respond_to(:board) }
		its(:board){ should == [[" "," "," "][" "," "," "],[" "," "," "]] }
	end

	describe "Player" do
		before { @player = Player.new("O") }
		subject { @player }
		it { should respond_to(:symbol) }
		its(:symbol) { should == "O" }
	end
end