def add(a,b)
	a+b
end

def subtract(a,b)
	a-b
end

def sum(arr)
	arr.empty? ? 0 : arr.inject(&:+)
end

def multiply(*args)
	args.empty? ? 1 : args.inject(&:*)
end

def power(a,b)
	a**b
end

def factorial(n)
	result = 1
	n.times do |i|
		result*=(i+1) 
	end
	result
end