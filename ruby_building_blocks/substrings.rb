#Given an input string and a dictionary (array of words), 
#return a hash of occurrences of the dictionary words in the string 

def substrings(str, dictionary)
	str = str.downcase
	dictionary = dictionary.map(&:downcase)
	result = Hash.new(0)

	dictionary.each do |word|
		start = 0
		until str.index(word,start).nil? do
			result[word] += 1
			start = str.index(word,start) + 1
		end
	end
	result
end


dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("below", dictionary) 
# => {"below"=>1, "low"=>1}

puts substrings("Howdy partner, sit down! How's it going?", dictionary) 
#=> {"down"=>1, "how"=>2, "howdy"=>1,"go"=>1, "going"=>1, "it"=>2, "i"=> 3, "own"=>1,"part"=>1,"partner"=>1,"sit"=>1}