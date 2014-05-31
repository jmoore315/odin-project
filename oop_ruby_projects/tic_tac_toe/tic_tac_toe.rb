class Player
	attr_accessor :symbol

	def initialize(symbol)
		@symbol = symbol
	end
end


class Game
	attr_accessor :players, :board, :turn

	def initialize
		setup_game
	end

	def setup_game
		@game_over = false
		@board = [[" "," "," "],[" "," "," "],[" "," "," "]]
		@players = [Player.new("O"),Player.new("X")]
		@turn = 0
	end

	def game_over?
		@game_over
	end

	def mark(row,col,player)
		board[row][col] = player.symbol
	end

	def display_board
		system "clear" or system "cls"
		puts 
		board.each_with_index do |row,col_index|
			row.each_with_index do |val,index|
				print val 
				print " | " if index < 2
			end
			puts 
			if col_index < 2 
				print "----------"
			end
			puts 
		end
	end

	def display_game_info
		if @winner
			puts @winner + "'s won!"
		else 
			puts "Cats game!"
		end
	end

	def new_game?
		print "Play again? (y/n)"
		valid = false
		until valid do 
			play_again = gets.chomp
			if play_again.downcase == 'y' || play_again.downcase == 'n'
				valid = true
				return play_again.downcase == 'y' ? true : false
			else 
				puts "Invalid input."
			end
		end
	end

	def get_move
		valid = false
		until valid do
			puts "#{players[@turn].symbol}'s to play. Enter the row,column pair you wish to play (zero-indexed)."
			move = gets.chomp
			if move.match(/[0,1,2][,][0,1,2]/) && move.size == 3 && is_available(move)
				valid = true
				mark(move[0].to_i,move[2].to_i,players[turn])
			else
				puts "Invalid move, try again."
			end
		end
	end

	def is_available(move)
		board[move[0].to_i][move[2].to_i] == " "
	end
	def play_game
		loop do 
			until game_over? do
				display_board
				get_move
				check_for_game_over
				switch_turn
			end
			display_board
			display_game_info
			play_again = new_game?
			break unless play_again
			setup_game
		end
		puts "Thanks for playing!"
	end

	def switch_turn
		if @turn == 0 
			@turn = 1
		else 
			@turn = 0
		end
	end
end

def check_for_game_over
	#check for cats game
	cats_game = board.flatten.none? { |i| i == " " }
	if cats_game
		@winner = false
		@game_over = true
	else
	#top, left, diagnol top to bottom
		mark = board[0][0]
		if mark != " " && ((board[0][1] == mark && board[0][2] == mark) || (board[1][0] == mark && board[2][0] == mark) || (board[1][1] == mark && board[2][2] == mark))
		  @game_over = true
		  @winner = mark 
		  return
		end
		mark = board[0][1]
		if mark != " " && board[1][1] == mark && board[2][1] == mark
		  @game_over = true
		  @winner = mark 
		  return
		end
		mark = board[0][2]
		if mark != " " &&  ((board[1][2] == mark && board[2][2] == mark) ||  (board[1][1] == mark && board[2][0] == mark))
		  @game_over = true
		  @winner = mark
		  return
		end
		mark = board[1][0]
		if mark != " " &&  board[1][1] == mark && board[1][2] == mark 
		  @game_over = true
		  @winner = mark
		  return
		end
		mark = board[2][0] 
		if mark != " " &&  board[2][1] == mark && board[2][2] == mark 
		  @game_over = true
		  @winner = mark
		  return
		end
	end
end

Game.new.play_game

