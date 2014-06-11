stopwords = %w{the a by on for of are with just but and to the my I has some in}
lines = File.readlines(ARGV[0])
text = lines.join

line_count = lines.length
total_characters = text.length
words = text.split
word_count = words.count
total_non_space_characters = words.inject(0) { |count,word| count + word.length }
sentence_count = text.split(/\.|\?|!/).length
paragraph_count = text.split(/\n\n/).length

#Get words that are not stop words
good_words = words.select { |word| !stopwords.include? word }
percentage_non_stop_words = (good_words.length.to_f / words.length) * 100

#Summarize the text with some choice sentences
sentences = text.gsub(/\s+/,' ').strip.split(/\.|\?|!/)
sentences_sorted = sentences.sort_by { |sentence| sentence.length }
one_third = sentences.length / 3
ideal_sentences = sentences_sorted.slice(one_third,one_third + 1). select { |sentence| sentence =~ /are|is/ }

puts "#{line_count} lines."
puts "#{word_count} words."
puts "#{total_characters} characters."
puts "#{total_non_space_characters} characters (excluding whitespace)."
puts "#{sentence_count} sentences."
puts "#{paragraph_count} paragraphs."
puts "#{sentence_count*1.0 / paragraph_count} sentences per paragraph."
puts "#{word_count*1.0 / sentence_count} words per sentence."
puts "#{percentage_non_stop_words} of words are non-fluff words."
puts "Summary:\n\n" + ideal_sentences.join(". ")
puts "-- End of analysis."
