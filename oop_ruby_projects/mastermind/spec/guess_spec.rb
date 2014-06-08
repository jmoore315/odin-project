require './spec_helper'

describe Guess do 
	before :each do
		@guess = Guess.new "RBRG"
	end

	describe "#new" do 
		it "returns a new Guess object" do
			@guess.should be_an_instance_of Guess
		end

		it "takes 1 parameter and throws an ArgumentError when given no parameter" do
			lambda { guess = Guess.new }.should raise_exception ArgumentError
		end

		it "should set the guess data when passed valid colors" do
			@guess.data.should == "RBRG"
		end

		it "raises an ArgumentError when passed a non-string" do 
			lambda { guess = Guess.new 5 }.should raise_exception ArgumentError
		end

		it "raises an ArgumentError when passed invalid colors" do
			lambda { guess = Guess.new "XHAL" }.should raise_exception ArgumentError
		end

		it "raises an ArgumentError when passed more than 4 colors" do
			lambda { guess = Guess.new "RBWMG" }.should raise_exception ArgumentError
		end
	end

	describe "#compare" do 
		it "returns a string" do 
			result = @guess.compare(Guess.new "WBBG")
			result.should be_an_instance_of String
		end

		it "returns a dash for a correct color in the wrong place" do
			result = @guess.compare(Guess.new "WWWR")
			result.should == "-"
		end

		it "returns a dot for a correct color in the correct place" do
			result = @guess.compare(Guess.new "RWWW")
			result.should == "."
		end

		it "returns multiple dots and dashes for multiple correct colors" do 
			result = @guess.compare(Guess.new "RRBG")
			result.should == ". . - -"
		end
	end

	describe ".get_all_codes" do
		it "returns an array of all guess permutations" do 
			all_possible_codes = Guess.get_all_codes
			all_possible_codes.length.should == 6**4
		end
	end

	describe "#has_n_colors_matching?" do
		context "with n = 0" do 
			it "with no colors matching" do 
				guess = Guess.new "YYYY"
				result = @guess.has_n_colors_matching?(guess, 0)
				result.should be_true 
			end
			it "with a matching color" do 
				guess = Guess.new "RYYY"
				result = @guess.has_n_colors_matching?(guess, 0)
				result.should be_false
			end
		end
		context "with n = 1" do 
			it "with no colors matching" do
				guess = Guess.new "YYYY"
				result = @guess.has_n_colors_matching?(guess, 1)
				result.should be_false
			end 
			it "with a matching color" do 
				guess = Guess.new "RYYY"
				result = @guess.has_n_colors_matching?(guess, 1)
				result.should be_true
			end
			it "with two matching colors" do 
				guess = Guess.new "RBYY"
				result = @guess.has_n_colors_matching?(guess, 1)
				result.should be_false
			end
		end
	end
end
