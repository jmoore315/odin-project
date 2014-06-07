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

	def get_guess(player_type)
		if player_type == :human
			guess = get_guess_from_human
		elsif player_type == :computer
			guess = get_guess_from_computer
		else 
			raise ArgumentError, "get_guess expects either :computer or :human parameter"
		end
		@guesses.push guess
		@guess_results.push @code.compare(guess)
	end

	private 
		def get_code_from_computer
			charset = %w{ R B G W M Y}
			result = ""
			4.times do 
				result += charset.shuffle.first
			end
			@code = Guess.new result
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

		def get_guess_from_computer
			charset = %w{ R B G W M Y}
			result = ""
			4.times do 
				result += charset.shuffle.first
			end
			Guess.new result
		end

		def get_guess_from_human
			puts "Enter guess: " 
			loop do 
				begin 
					input = gets.chomp
					guess = Guess.new input
					return guess
				rescue 
					puts "Try again"
			end
		end
	end
end