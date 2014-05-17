class Timer
	attr_accessor :seconds


	def initialize
		@seconds = 0
		@hour_digit = 0
		@minute_digit = 0
		@second_digit = 0
	end

	def time_string
		set_digits(@seconds)
		"#{@hour_digit}:#{@minute_digit}:#{@second_digit}"
	end

	private
		@hour_digit
		@minute_digit
		@second_digit

		def set_digits(seconds)
			while seconds >= 3600
				@hour_digit += 1
				seconds -= 3600
			end
			@hour_digit = pad_digit(@hour_digit)
			while seconds >= 60
				@minute_digit += 1
				seconds -= 60
			end
			@minute_digit = pad_digit(@minute_digit)
			@second_digit = pad_digit(seconds)
		end

		def pad_digit(num)
			str = "#{num}"
			if str.length == 1
				"0#{num}"
			else 
				str
			end
		end
end