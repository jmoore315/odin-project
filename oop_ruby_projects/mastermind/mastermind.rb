class Mastermind
	#init (with option for player guess or computer guess)

	#play (starts play loop)

	#get_guess (gets guess from player or computer)

	#evaluate_guess (evaluates correctness of guess and sets keys appropriately)

	#display (prints out guesses and keys, relevant info (num guesses remaining, etc))

	#members: 
		#possible_codes: list of all possible codes 




end




#classes:
	#Mastermind (state of game, plays, etc)
		#Board
			#Guess[]  -  array of guesses. Each guess has a color symbol array representing the guess
			#GuessResult[]  - array of guess results. Num correct spot, num correct color 