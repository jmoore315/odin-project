require_relative './bst.rb'

def get_target_and_search(bst, search_type)
  puts "Enter the number you wish to search for:"
  print ">"
  value = gets.chomp.to_i 
  if search_type == '1'
    node = bst.breadth_first_search(value)
  elsif search_type == '2'
    node = bst.depth_first_search(value)
  else
    node = bst.dfs_rec(value)
  end
  if node.nil?
    puts "#{value} is not in the tree."
  else 
    puts "Found #{value} in the tree!"
  end
end


valid = false
until valid do 
  puts "Enter a list of numbers separated by spaces to insert into a new BST"
  print ">"
  nums = gets.chomp.split(" ")
  if nums.all? { |num| num.match /\d+\z/ }
    nums.map! { |num| num.to_i}
    valid = true
  else 
    puts "Bad entry. Try again."
  end
end


bst = BST.build_tree(nums) 

loop do 
  puts "Enter what you would like to do. Options: 1 (breadth first search), 2 (depth first search), 3 (dfs recursive)"
  print ">"
  input = gets.chomp 
  if input == '1' || input == '2' || '3'
    get_target_and_search(bst, input)
  end
end


