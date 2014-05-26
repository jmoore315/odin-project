# Given an array of stock prices, where entries represent the price of a stock on a given day, 
# return a pair of days representing the best days to buy/sell. 
# Buy day must be before sell day

def stock_picker(arr)
	profit = 0				#current best profit
	buy_index = -1 		#buy index of best profit 
	sell_index = -1 	#sell index of best profit

	temp_buy_index = 0

	while temp_buy_index < arr.length-1 do
		#loop until finding the smallest value in the current subarray
		while  arr[temp_buy_index] >= arr[temp_buy_index+1] && temp_buy_index < arr.length-1 do
			temp_buy_index += 1
		end

		#get biggest value after this index
		i = temp_sell_index = temp_buy_index+1
		while i < arr.length
			temp_sell_index = i if arr[i] > arr[temp_sell_index]
			i += 1
		end

		#adjust current best profit and indices if necessary
		if arr[temp_sell_index] - arr[temp_buy_index] > profit
			buy_index = temp_buy_index
			sell_index = temp_sell_index
			profit = arr[temp_sell_index] - arr[temp_buy_index]
		end

		#continue to the next sequence of the array
		temp_buy_index += 1
	end
	return -1,-1 if buy_index == -1
	return buy_index, sell_index
end


puts stock_picker([17,3,6,9,15,8,6,1,10])
#=> [1,4]  # for a profit of $15 - $3 == $12