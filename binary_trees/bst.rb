require_relative './node.rb'

class BST
  def BST.build_tree(arr)
    bst = BST.new
    arr.each { |data| bst.add(data) }
    puts "Tree created!"
    bst
  end

  def add(data)
    if @root.nil? 
      @root = Node.new(data)
    else
      new_node = Node.new(data)
      add_node(new_node, @root)
    end
  end

  def breadth_first_search(target)
    queue = [@root]
    until queue.empty? do 
      node = queue.first 
      puts "At #{node.value}"
      if node.value == target 
        return node
      else 
        queue.delete_at(0) 
        queue << node.left_child if node.left_child
        queue << node.right_child if node.right_child
      end
    end
    nil
  end

  def depth_first_search(target)
    stack = [@root]
    until stack.empty? do 
      node = stack.last 
      puts "At #{node.value}"
      if node.value == target 
        return node 
      else 
        stack.delete_at (stack.length-1)
        stack << node.right_child if node.right_child
        stack << node.left_child  if node.left_child 
      end
    end
    nil
  end

  def dfs_rec(target, current_node = @root)
    puts "At #{current_node.value}" unless current_node.nil?
    return current_node if current_node.nil? || current_node.value == target
    return dfs_rec(target,current_node.left_child) || dfs_rec(target,current_node.right_child)
  end

  private
    def add_node(new_node, ancestor)
      if new_node.value < ancestor.value 
        if ancestor.left_child.nil?
          ancestor.left_child = new_node
          new_node.parent = ancestor 
        else
          add_node(new_node, ancestor.left_child)
        end
      else
        if ancestor.right_child.nil?
          ancestor.right_child = new_node
          new_node.parent = ancestor
        else
          add_node(new_node, ancestor.right_child)
        end
      end
    end
end


