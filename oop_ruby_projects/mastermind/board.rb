require_relative './guess'

class Board
	attr_accessor :guesses, :guess_results, :code, :max_guesses, :winner, :possible_codes
	@@max_guesses = 10
	@game_over = false
	@winner = false

	def initialize 
		@guesses = []
		@guess_results = []
		@possible_codes = nil
	end

	def get_code(codemaker)
		if codemaker == :human
			get_code_from_human
		elsif codemaker == :computer
			get_code_from_computer
		else 
			raise ArgumentError, "get_code expects either :computer or :human parameter"
		end
	end

	def get_guess(codemaker)
		if codemaker == :human
			guess = get_guess_from_computer
		elsif codemaker == :computer
			guess = get_guess_from_human
		else 
			raise ArgumentError, "get_guess expects either :computer or :human parameter"
		end
		@guesses.push guess
		result = @code.compare(guess)
		@guess_results.push result
		if result == ". . . ."
			@game_over = true
			@winner = true
		elsif 
			@guesses.length == @@max_guesses
			@game_over = true 
			@winner = false
		end
		if codemaker == :human
			remove_invalid_codes(guess,result)
		end
	end

	def clear
		@guesses = []
		@guess_results = []
		@code = nil
		@winner = false
		@game_over = false
		@possible_codes = nil
	end

	def display
		puts " #|     Guess    |   Result" 
		puts "-----------------------------"
		10.times.each do |i|
			print " " if i<9
			print i+1
			print "|  "
			if guesses[i]
				print @guesses[i].data.split("").join("  ")
				print "  |  "
				print @guess_results[i]
			end
			puts
		end
	end

	def game_over?
		@game_over
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
			puts "Enter a secret code of 4 letters representing colors. Colors are #{Guess.colors_to_s}." 
			valid_input = false 
			until valid_input do 
				begin 
					input = gets.chomp
					@code = Guess.new input
					valid_input = true
				rescue 
					puts "Invalid input. Please try again."
				end
			end
		end

		def get_guess_from_computer
			@possible_codes ||= Guess.get_all_codes
			@possible_codes.shuffle.first
		end

		def get_guess_from_human
			puts
			puts "Enter guess of 4 letters representing colors. Colors are #{Guess.colors_to_s}." 
			loop do 
				begin 
					input = gets.chomp
					guess = Guess.new input
					return guess
				rescue 
					puts "Invalid guess input. Please try again."
				end
			end
		end

		def remove_invalid_codes(guess,guess_result)
			puts "here!"
			new_array = []
			num_dashes_and_dots = get_num_dashes_and_dots(guess_result)
			if guess_result == ""
				@possible_codes.each do |code|
					guess.data.each_char do |c| 
						unless code.data.count(c) > 0 
							new_array.push(code)
						end
					end
				end
			else
				@possible_codes.each do |code|
					new_array.push code if code.has_n_colors_matching?(guess, num_dashes_and_dots)
				end
			end 
		  #remove code if n does not match
		  #remove code if n-1 does not match
		  @possible_codes = new_array.uniq
		  @possible_codes.delete guess 
		end

		def get_num_dashes_and_dots(guess_result)
			guess_result.count('.') + guess_result.count('-')
		end

end