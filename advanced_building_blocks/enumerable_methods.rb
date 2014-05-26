module Enumerable
  def my_each
    self.length.times do |i|
      yield self[i] 
    end
  end

  def my_each_with_index
    self.length.times do |i|
      yield(self[i],i)
    end
  end

  def my_select
    result = []
    self.my_each { |i| result << i if yield(i)}
    result 
  end

  def my_all?
    self.my_each { |i| return false unless yield i}
    true
  end

  def my_any?
    self.my_each { |i| return true if yield i}
    false
  end

  def my_none?
    self.my_each { |i| return false if yield i}
    true
  end

  def my_count
    count = 0
    self.my_select { |i| yield(i) }.length
  end

  def my_map
    result = []
    self.my_each { |i| result << yield(i) }
    result
  end

  def my_inject(sym)
    return self if self.empty?
    result = self[0]
    self.my_each_with_index { |num,index| result = result.send sym, num if index > 0  }
    result
  end

  #Takes proc instead of block
  def my_map_2(proc)
    result = []
    self.my_each { |i| result << proc.call(i) }
    result
  end

  #Takes both proc and block
  def my_map_3(proc,&block)
    result = []
    self.my_each { |i| result << yield(proc.call(i)) }
    result
  end
end