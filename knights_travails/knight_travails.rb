def get_possible_moves(loc)
  x = loc[0]
  y = loc[1]
  moves = [[x+1,y+2],[x-1,y+2],[x+1,y-2],[x-1,y-1],[x+2,y+1],[x+2,y-1],[x-2,y-1],[x-2,y+1]]
  moves.select { |move| valid?(move) }
end

def valid?(location)
  location.class == Array && location.length == 2 && location[0].between?(0,7) && location[1].between?(0,7)
end

def knight_moves(loc_a, loc_b) 
  unless valid?(loc_a) && valid?(loc_b)
    puts "Invalid locations."
    return
  end
  queue = [[loc_a, [loc_a]]]
  until queue.empty? do 
    location = queue.first 
    if location[0] == loc_b 
      result = location[1]
      break
    else 
      queue.delete_at(0)
      possible_moves = get_possible_moves(location[0])
      possible_moves.each do |move| 
        queue << [move, location[1].clone << move]
      end
    end
  end
  puts "You made it in #{result.length - 1} move(s)! Here's your path:" 
  return result 
end



