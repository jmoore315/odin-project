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
	end
end