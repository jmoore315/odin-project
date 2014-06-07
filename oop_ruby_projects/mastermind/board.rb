require './guess'

class Board
	attr_accessor :guesses, :guess_results, :code, :max_guesses, :winner
	@@max_guesses = 10
	@game_over = false
	@winner = false

	def initialize 
		@guesses = []
		@guess_results = []
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
	end

	def clear
		@guesses = []
		@guess_results = []
		@code = nil
		@winner = false
		@game_over = false
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
			charset = %w{ R B G W M Y}
			result = ""
			4.times do 
				result += charset.shuffle.first
			end
			Guess.new result
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
end