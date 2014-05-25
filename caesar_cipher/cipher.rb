#This program takes an input string and ciphers it using a simple character shift.

def caesar_cipher(str,shift)
	str.split('').map { |c| shift_char(c,shift) }.join
end

def shift_char(c,shift)
	#ignore puntuation
	if c =~ /\W/
		c
	else
		#if not punctuation, shift the letter, wrapping around lowercase / uppercase letters
		num = c.ord
		if c == c.upcase
			num = (num - 65 + shift) % 26 + 65
		else
			num = (num - 97 + shift) % 26 + 97
		end
		num.chr
	end
end