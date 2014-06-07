require './board'

class Mastermind
	attr_accessor :board, :guesses_made, :codemaker


	def initialize 
		@board = Board.new
	end

	def play (codemaker = :computer)
		@guesses_made = 0
		@board.clear
		@codemaker = codemaker
		@board.get_code(codemaker)
		game_over = false
		until game_over do 
			print_header
			print_how_to_play
			@board.display
			@board.get_guess(codemaker)
			game_over = @board.game_over?
		end
		print_header
		print_how_to_play
		@board.display
		print_game_result
		puts "Play again? (y/n)"
		valid = false
		until valid 
			input = gets.chomp 
			if input.upcase == 'Y' or input.upcase == 'N'
				valid = true
			else
				puts "Please enter 'y' or 'n'"
			end
		end
		if input == 'n'
			puts "Thanks for playing!"
			exit
		end
	end

	def display_info
		puts "You have #{@board.max_guesses - @board.guesses.length} guess remaining."
		puts "Colors are: #{Guess.colors_to_s}"
		puts "Enter "
	end

	def play_from_terminal
		loop do
			print_header
		  print_how_to_play
			puts "A new game has begun!"
			puts
			get_codemaker
			play(codemaker)
			@board.clear 
		end
	end

	def get_codemaker
		puts "Would you like to be the codemaker or codebreaker? Enter 1 to be the codemaker, 2 to be the codebreaker."
		valid = false
		until valid do 
			value = gets.chomp
			if value == "1" or value == "2"
				valid = true
			else
				puts "Invalid input. Please enter either 1 or 2."
			end
		end
		if value == "1" 
			@codemaker = :human
		else
			@codemaker = :computer
		end
	end

	def print_header
		clear_screen
		puts "*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*"
		puts "Welcome to Mastermind!"
		puts "*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*~~*"
		puts
	end 

	def print_how_to_play
		puts "How to play:"
		puts "Mastermind is a logic game where the objective is to guess your oponents secret code."
		puts "The code is a sequence of 4 colors in a specific order. Each turn, you will guess a sequence of colors to try to guess the code."
		puts "For every correct color in a correct place, you will receive a '.'"
		puts "For every correct color in an incorrect place, you will receive a '-'"
		puts "This game allows for both human and computer 'codebreakers'."
		puts "Thanks for playing and good luck!"
		puts
	end

	def print_game_result
		puts 
		if @board.winner
			if codemaker == :computer
				puts "You won! You solved the computer's code in #{@board.guesses.length} guesses!"
			else 
				puts "The computer solved your code in #{@board.guesses.length} guesses!"
			end
		else
			if codemaker == :computer
				print "Wump wump wump... you lost! "
				puts "The code was: #{@board.code.pretty_print}."
			else 
				puts "Congrats, you stumped the computer!"
			end
			puts
		end
	end

	def clear_screen
		system "clear" or system "cls" 	#clear stdout
	end
end

if __FILE__ == $0
	game = Mastermind.new
	game.play_from_terminal
end
