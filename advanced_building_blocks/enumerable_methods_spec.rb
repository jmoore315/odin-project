require './enumerable_methods.rb'
require 'rspec'

describe "Enumerable" do 
	before(:each) do 
		@arr = [1,2,3,4,5]
		@value = 0
	end


	describe ".my_each" do
		it "should add elements of an array to an existing value" do
			@arr.my_each { |i| @value += i }
			@value.should == 15
		end
	end

	describe ".my_each_with_index" do
		it "should add each element times its index to a value" do
			@arr.my_each_with_index { |elem, index| @value += index*elem }
			@value.should == 40
		end
	end

	describe ".my_select" do 
		it "should select elements greater than 2" do 
			result = @arr.my_select { |i| i > 2 }
			result.should == [3,4,5]
		end
	end

	describe ".my_all?" do
		it "should return true when all elements satisfy the condition" do
			result = @arr.my_all? { |i| i > 0 }
			result.should be_true
		end

		it "should return false when an element does not satisfy the condition" do
			result = @arr.my_all? { |i| i == 3 }
			result.should be_false
		end
	end

	describe ".my_any?" do
		it "should return true if at least one element satisfies the condition" do
			result = @arr.my_any? { |i| i == 2}
			result.should be_true
		end

		it "should return false if no elements satisfy the condition" do
			result = @arr.my_any? { |i| i === String }
			result.should be_false
		end
	end

	describe ".my_none?" do 
		it "should return true if no elements satisfy the condition" do
			result = @arr.my_none? { |i| i > 10 } 
			result.should be_true
		end

		it "should return false if an element does satisfy the condition" do
			result = @arr.my_none? { |i| i % 2 == 0 }
		end
	end

	describe ".my_count" do
		it "should count all elements satisfying the criteria" do
			result = @arr.count { |i| i %2 == 0 }
			result.should == 2
		end
	end

	describe ".my_map" do 
		describe "with only a block passed" do
			it "should increment each element by 1" do 
				result = @arr.my_map { |i| i + 1 }
				result.should == [2,3,4,5,6]
			end
		end

		describe "with a proc passed" do 
			it "should increment each element by 1" do
				proc = Proc.new { |i| i+ 1 }
				result = @arr.my_map_2(proc)
				result.should == [2,3,4,5,6]
			end
		end

		describe "with both a proc and a block passed" do
			it "should apply both the proc and the block" do
				proc = Proc.new { |i| i+ 1 }
				result = @arr.my_map_3(proc) { |i| i+1 }
				result.should == [3,4,5,6,7]
			end
		end
	end

	describe ".my_inject" do 
		describe "should apply the operator to all elements of the array" do
			it "should add all elmenets" do
				result = @arr.my_inject(:+)
				result.should == 15
			end

			it "should multiply all elements" do
				result = @arr.my_inject(:*)
				result.should == 120
			end
		end
	end
end