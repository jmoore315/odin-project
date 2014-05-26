require './bubble_sort.rb'
require 'rspec'

describe "Bubble Sort" do 
	describe "without comparator" do
		it "should sort a random int array" do
			arr = [1,3,6,2,4,10,7,11]
			sorted_arr = bubble_sort(arr)
			sorted_arr.should == [1,2,3,4,6,7,10,11]
		end

		it "should sort an already sorted array" do
			arr = [1,2,3,4]
			sorted_arr = bubble_sort(arr)
			sorted_arr.should == [1,2,3,4]
		end

		it "should sort an array of two elements" do
			arr = [2,1]
			sorted_arr = bubble_sort(arr)
			sorted_arr.should == [1,2]
		end

		it "should sort an array of one element" do
			arr = [1]
			sorted_arr = bubble_sort(arr)
			sorted_arr.should == [1]
		end

		it "should return an empty array when passed an empty array" do
			arr = []
			sorted_arr = bubble_sort(arr)
			sorted_arr.should == []
		end
	end

	describe "with a comparator block" do
		it "should sort based on the comparator" do
			arr = ["hi","hello","hey"]
			sorted_arr = bubble_sort_by(arr) { |left, right| right.length - left.length }
			sorted_arr.should == ["hi", "hey", "hello"]
		end
	end
end

