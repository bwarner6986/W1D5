require 'byebug'

class PolyTreeNode

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent
    @parent
  end

  def parent=(node)
    if parent != nil && parent.children.include?(self)
      parent.children.reject! { |ele| ele == self }    
    end
    if node != nil
      node.children << self if !node.children.include?(self)
    end 
    @parent = node
     
  end

  def children 
    @children
  end

  def add_child(child)
    child.parent = self
  end

  def remove_child(child)
    if self.children.include?(child)
      child.parent = nil 
    else
      raise "This node is not my child"
    end
  end

  def value
    @value
  end

  def dfs(target_value)
    return self if value == target_value

    self.children.each do |child|
      node = child.dfs(target_value)
      return node unless node.nil?
    end

    nil  
  end

  def bfs(target_value)
    queue = []
    queue << self 

    until queue.empty?
      inspected_node = queue.shift
      if inspected_node.value == target_value
        return inspected_node
      else
        inspected_node.children.each { |child| queue << child }
      end 
    end
  end

end

