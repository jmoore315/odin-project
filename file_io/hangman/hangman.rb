class Game

  def initialize
    @guesses = []
    @guess_results = [] #boolean array of the same length as @word. Entry is 1 if correct, 0 otherwise
    @word_list = load_words
    @word = select_random_word
    puts "word length is #{@word.length}"
    gets
    @remaining_guesses = 6
  end

  def save
  end

  def load 
  end

  def play
    until won? or lost? do 
      display_game_info
      move = get_move 
      compute_results(move)
    end
    if won?
      puts "Congrats, you won!"
    else 
      puts "Sorry, you lost! The correct word was #{@word} with length #{@word.length}"
    end
  end

  def hangman_picture
    case @remaining_guesses
    when 0   
      %{
            ______
           |      |
          _O_     |
           |      |
          / \\    _|_
      }
    when 1
      %{
            ______
           |      |
          _O_     |
           |      |
          /      _|_
      }
    when 2
      %{
            ______
           |      |
          _O_     |
           |      |
                 _|_
      }
    when 3   
      %{
            ______
           |      |
          _O      |
           |      |
                 _|_
      }
    when 4
      %{
            ______
           |      |
           O      |
           |      |
                 _|_
      }
    when 5
      %{
            ______
           |      |
           O      |
                  |
                 _|_
      }
    when 6
      %{
            ______
           |      |
                  |
                  |
                 _|_
      }
    end
  end

  def display_game_info 
    clear_screen
    puts "Hangman:\n\n"
    puts hangman_picture
    puts 
    print_guesses
    print_results
    puts "\n"
  end

  def load_words
    words = []
    lines = File.readlines("5desk.txt")
    lines.each do |word|
      words.push word
    end
  end

  def select_random_word
    valid = false
    until valid do 
      word = @word_list[rand(0...@word_list.length)]
      valid = word.length.between?(5,12)
      puts "word length is #{word.length}"
    end
    @word = word
    puts "word length is #{@word.length}"
    word
  end

  def won?
    @guess_results.count { |result| result == 1 } == @word.length 
  end

  def lost?
    @remaining_guesses == 0 
  end

  def clear_screen
    system "clear" or system "cls"  #clear stdout
  end 

  def print_options
    "Enter a letter to guess (case insensitive): "
  end 

  def print_guesses
    print "Guesses: "
    @guesses.each do |guess|
      print guess, " "
    end
    puts "\n\n"
  end

  def print_results
    print "Result: "
    @word.length.times do |i|
      if @guess_results[i] == 1
        print " #{@word[i]} "
      else
        print " _ "
      end
    end
    puts
  end

  def get_move
    print_options
    valid = false
    until valid do 
      move = gets.chomp.upcase 
      if move.length == 1 && move.match(/[A-Z]/)
        if @guesses.include? move 
          puts "You already guessed that letter you fool! Try again."
        else
          @guesses.push move
          valid = true
        end
      else
        puts "Bad entry...enter a letter a-z to guess."
      end
    end
    move 
  end

  def compute_results(move)
    any_correct = false
    @word.length.times do |i|
      if @word[i].upcase == move
        @guess_results[i] = 1 
        any_correct = true
      end 
    end
    @remaining_guesses -= 1 unless any_correct
  end
end



puts "Welcome to Hangman!"
loop do 
  puts "Enter 1 to start a new game, 2 to load a previous game, 3 to quit."
  value = ""
  loop do
    value = gets.chomp
    puts value
    if value.length == 1 && %w(1 2 3).include?(value)
      break
    else
     puts "Invalid input. Please enter 1 to start a new game, 2 to load a previous game, 3 to quit."
   end
  end
  case value.to_i
  when 1 
    game = Game.new 
  when 2 
    game = Game.load
  when 3
    puts "Thanks for playing!"
    exit
  end
  game.play 
end