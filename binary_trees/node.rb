class Node
  attr_accessor :value, :parent, :left_child, :right_child

  def initialize(value, options = {})
    @value = value
    @parent = options[:parent]
    @left_child = options[:left_child]
    @right_child = options[:right_child]
  end
end

