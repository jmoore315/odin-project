require './spec_helper'

describe Guess do 
	before :each do
		@guess = Guess.new 
	end

	describe "#new" do 
		it "returns a new Guess object" do
			@guess.should be_an_instance_of Guess
		end

	end
end
