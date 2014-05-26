#Ruby bubble sort implemenetation

def bubble_sort(input_arr)
	arr = input_arr.clone
	arr.length.times do
		swap_made = false
		arr.each_with_index do |elem, index|
			if index+1 < arr.length && elem > arr[index+1]
				arr[index],arr[index+1] = arr[index+1],arr[index]
				swap_made = true
			end
		end
		break unless swap_made
	end
	arr
end


#Bubble sort but with a block of 2 arguments passed in to serve as comparator 
def bubble_sort_by(input_arr)
	arr = input_arr.clone
	arr.length.times do
		swap_made = false
		arr.each_with_index do |elem, index|
			if index+1 < arr.length && yield(elem, arr[index+1]) < 0
				arr[index],arr[index+1] = arr[index+1],arr[index]
				swap_made = true
			end
		end
		break unless swap_made
	end
	arr
end


p bubble_sort_by(["hi","hello","hey"]) { |left, right| right.length - left.length }
# #=> ["hi", "hey", "hello"]