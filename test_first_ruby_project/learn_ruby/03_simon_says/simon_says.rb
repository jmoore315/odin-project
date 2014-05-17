def echo(word)
	word
end

def shout(words)
	words.upcase
end

def repeat(word, times=2)
	arr = Array.new(times) { word }
	arr.join " "
end

def start_of_word(word, letters)
	word[0...letters]
end

def first_word(words)
	words[/(\S+)/, 1]
end

Lowercase_words = %w{a an the it and but for or over in of}

def titleize(words)
	words.split(" ").each_with_index.map { |i,index| Lowercase_words.include?(i) && index > 0 ? i : i.capitalize }.join(" ")
end