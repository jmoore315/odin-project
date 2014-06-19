gem "minitest"
require 'minitest/autorun'

def fib(n)
  if n < 1 
    return 0 
  else 
    current = 0
    next_num = 1 
    n.times do 
      temp = next_num
      next_num += current
      current = temp 
    end
    current 
  end
end

def fib_recursive(n) 
  return 0 if n < 1
  return 1 if n < 3
  return fib_recursive(n-1) + fib_recursive(n-2)
end

def fib_with_cache(n, cache = nil)
  puts n
  return 0 if n < 1
  return 1 if n==2 || n==1
  a = fib_with_cache(n-2)
  return a + cache if cache
  b = fib_with_cache(n-1,a)
  return a+b
end


# puts "Fib(0) is: #{fib(0)} (should be 0)"
# puts "Fib(1) is: #{fib(1)} (should be 1)"
# puts "Fib(2) is: #{fib(2)} (should be 1)"
# puts "Fib(3) is: #{fib(3)} (should be 2)"
# puts "Fib(6) is: #{fib(6)} (should be 8)"

# puts "Fib_rec(0) is: #{fib_recursive(0)} (should be 0)"
# puts "Fib_rec(1) is: #{fib_recursive(1)} (should be 1)"
# puts "Fib_rec(2) is: #{fib_recursive(2)} (should be 1)"
# puts "Fib_rec(3) is: #{fib_recursive(3)} (should be 2)"
# puts "Fib_rec(6) is: #{fib_recursive(6)} (should be 8)"

# puts "Fib_with_cache(0) is: #{fib_with_cache(0)} (should be 0)"
# puts "Fib_with_cache(1) is: #{fib_with_cache(1)} (should be 1)"
# puts "Fib_with_cache(2) is: #{fib_with_cache(2)} (should be 1)"
# puts "Fib_with_cache(3) is: #{fib_with_cache(3)} (should be 2)"
#puts "Fib_with_cache(6) is: #{fib_with_cache(6)} (should be 8)"

