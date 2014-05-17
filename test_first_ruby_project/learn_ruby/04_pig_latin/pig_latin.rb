VOWELS = %w{a e i o u}

def translate(words)
	words.split(" ").map { |i| word_to_piglatin(i) }.join(" ")
end

def word_to_piglatin(word)
	capitalized = word.capitalize == word
	word.downcase!
	result = word
	unless VOWELS.include? word[0] 
		#get index of first vowel
		index = 0
		i = 0
		while i < word.split("").length
			if VOWELS.include? word[i] 
				index = i
				break
			elsif word[i] == 'q' && i < word.length-1 && word[i+1] == 'u'
				i+=1
			end
			i+=1
		end
		result = result[index..-1] + result[0...index]
	end
	result += "ay"
	capitalized ? result.capitalize : result
end