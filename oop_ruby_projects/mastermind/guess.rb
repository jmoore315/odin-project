class Guess
	@@colors = {"R" => "Red","G" => "Green","B" => "Blue","Y" => "Yellow","M" => "Magenta","W" => "White"}
	#data held as a string of capital letters corresponding to colors
	attr_accessor :data

	def initialize (data)
		if data.class == String && data.strip.length == 4 && data.strip.upcase.split("").all? { |color| @@colors.include? color }
			@data = data.upcase
		else
			raise ArgumentError 
		end
	end

	def compare(other_guess)
		num_dots = 0
		num_dashes = 0

		@data.split("").uniq.each do |color|
			num_dashes += [@data.count(color), other_guess.data.count(color)].min
		end

		4.times do |i|
			if @data[i] == other_guess.data[i]
				num_dots += 1
				num_dashes -= 1
			end
		end

		return (". "*num_dots + "- "*num_dashes).strip
	end

	def self.colors_to_s
		"R: Red, G: Green, B: Blue, Y: Yellow, M:Magenta, W: White"
	end

	def pretty_print
		data.split("").join("  ").strip
	end
end