module MergeSort
  def self.sort(arr)
    if arr.length == 1 
      arr
    else 
      middle = (arr.length - 1) / 2 
      merge(sort(arr[0..middle]), sort(arr[middle+1..arr.length-1]))
    end
  end

  private
  def self.merge(left,right)
    result = []
    until left.empty? || right.empty? do 
      if left[0] < right[0]
        result << left[0]
        left.delete_at(0)
      else
        result << right[0]
        right.delete_at(0)
      end
    end
    result += left if right.empty? 
    result += right if left.empty?
    result
  end

end

puts MergeSort.sort([5,2,10,11,10,4,1,20,25,0,5,2,1,13])


