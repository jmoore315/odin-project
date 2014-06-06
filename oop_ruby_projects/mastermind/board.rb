class Board
	attr_accessor :guesses, :guess_results, :code

	def initialize 
		@guesses = []
		@guess_results = []
	end

	def get_code(player_type)
		if player_type == :human
			get_code_from_human
		elsif player_type == :computer
			get_code_from_computer
		else 
			raise ArgumentError, "get_code expects either :computer or :human parameter"
		end
	end

	private 
		def get_code_from_computer
		end

		def get_code_from_human
			puts "Enter code: " 
			valid_input = false 
			until valid_input do 
				begin 
					input = gets.chomp
					@code = Guess.new input
					valid_input = true
				rescue 
					puts "Try again"
			end
		end
	end
end