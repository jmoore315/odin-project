require './spec_helper'

describe Board do 
	before :each do
		@board = Board.new 
	end

	describe "#new" do 
		it "returns a new Board object" do
			@board.should be_an_instance_of Board
		end

		it "should take no parameters" do 
			lambda { Board.new "param" }.should raise_exception ArgumentError
		end

		it "should create a new empty guesses array" do
			@board.guesses.should == []
		end

		it "should create a new empty guess result array" do
			@board.guess_results.should == []
		end
	end

	describe "#get_code" do 
		it "takes a input from a human codemaker until getting a valid code" do 
			@board.stub(:gets).and_return('BAD INPUT', 'RRAH', 'RGBY')
			@board.get_code(:human)
			@board.code.data.should == "RGBY"
		end

		it "generates a random code for computer codemaker" do 
			let(:randomized_code) { "WYBB" }
			Kernel.stub(:rand).with(anything) { randomized_code }
			@board.get_code(:computer)
			@board.code.should == "WYBB"
		end
	end
end
