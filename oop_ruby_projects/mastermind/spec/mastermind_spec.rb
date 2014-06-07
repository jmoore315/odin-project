require './spec_helper.rb'

describe Mastermind do 
	before :each do
		@mastermind = Mastermind.new 
	end

	describe "#new" do 
		it "returns a new Mastermind object" do
			@mastermind.should be_an_instance_of Mastermind
		end

		it "takes no parameters" do
			lambda { mastermind = Mastermind.new "Arg1" }.should raise_exception ArgumentError
		end

		it "should create a board with an empty guess array" do 
			@mastermind.board.guesses.should == []
		end

		describe "#play" do
			it "starts a new game with guesses_made set to 0" do 
				@mastermind.play 
				@mastermind.guesses_made.should == 0 
			end

			it "should clear the guesses array" do 
				@mastermind.board.guesses.push Guess.new "RGRR"
				@mastermind.play
				@mastermind.board.guesses.should == []
			end

			it "should clear the guess_results array" do
				@mastermind.board.guess_results.push ". . - -"
				@mastermind.play
				@mastermind.board.guess_results.should == []
			end

			it "should clear the code" do 
				@mastermind.board.code = Guess.new "RBRB"
				@mastermind.play
				@mastermind.board.code.should be_nil 
			end

			it "should accept a parameter for human codemaker type" do
				@mastermind.play (:human)
				@mastermind.codemaker.should == :human 
			end

			it "should accept a parameter for computer codemaker type" do 
				@mastermind.play (:computer)
				@mastermind.codemaker.should == :computer
			end
		end
	end
end