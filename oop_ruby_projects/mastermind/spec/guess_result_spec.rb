require './spec_helper'

describe GuessResult do 
	before :each do
		@guess_result = GuessResult.new 
	end

	describe "#new" do 
		it "returns a new GuessResult object" do
			@guess_result.should be_an_instance_of GuessResult
		end

	end
end
