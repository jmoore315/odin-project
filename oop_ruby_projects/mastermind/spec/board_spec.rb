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
			Array.any_instance.stub(:shuffle).and_return(["W"],["Y"],["B"],["B"])
			@board.get_code(:computer)
			@board.code.data.should == "WYBB"
		end
	end

	describe "#clear" do 
		before(:each) do 
			@board.guesses.push Guess.new "RBRB"
		end

		it "clears the guess array" do 
			@board.clear 
			@board.guesses.should == []
		end

		it "clears the guess_results array" do
			@board.clear
			@board.guess_results.should == []
		end

		it "clears the code" do 
			@board.clear
			@board.code.should be_nil
		end
	end

	describe "#get_guess" do 

		before do 
			@board.code = Guess.new "RGBY"
		end

		context "from a human codebreaker" do 

			before do 
				@board.stub(:gets).and_return('BAD INPUT', 'RRAH', 'RGBY')
				@board.get_guess(:human)
			end

			it "adds the guess to the guesses array" do 
				@board.guesses.first.data.should == "RGBY"
			end

			it "adds the correct guess result to the guess_results array" do 
				@board.guess_results.first.should == ". . . ."
			end
		end

		context "from a computer codebreaker" do
			before do 
				Array.any_instance.stub(:shuffle).and_return(["W"],["Y"],["B"],["B"])
				@board.get_guess(:computer)
			end

			it "adds the guess to the guesses array" do 
				@board.guesses.first.data.should == "WYBB"
			end

			it "adds the correct guess result to the guess_results array" do 
				@board.guess_results.first.should == ". -"
			end
		end
	end

	describe "#display" do 
		before do
   	 $stdout = StringIO.new
 		 end

  	after(:all) do
    	$stdout = STDOUT
  	end

		it "should print the current board" do 
			@board.guesses.push Guess.new "RGRG"
   	 	@board.guesses.push Guess.new "YYRG"
   	 	@board.guess_results.push ". . - -"
   	 	@board.guess_results.push ". -"
			@board.display
			
			$stdout.string.should == \
			 " #|     Guess    |   Result" + \
			 "\n-----------------------------" + \
			 "\n 1|  R  G  R  G  |  . . - -" + \
			 "\n 2|  Y  Y  R  G  |  . -" + \
			 "\n 3|  " + \
			 "\n 4|  " + \
			 "\n 5|  " + \
			 "\n 6|  " + \
			 "\n 7|  " + \
			 "\n 8|  " + \
			 "\n 9|  " + \
			 "\n10|  \n"
		end 
	end
end
