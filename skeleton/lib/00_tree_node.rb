require 'byebug'

class PolyTreeNode
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
    
  end

  def parent
    @parent
    
  end
  
  def children
    @children
    
  end
  
  def value 
    @value
  end
  
  def parent=(parent_node)
    # debugger
    self.parent.children.delete(self) if self.parent != nil
    
    @parent = parent_node
    
    unless parent_node == nil || parent_node.children.include?(self) 
      parent_node.children << self
    end
  end
  
  def add_child(child_node)
    child_node.parent = self
  end
  
  def remove_child(child_node)
    raise Exception.new("error") if child_node.parent == nil
    child_node.parent = nil
  end
  
  def dfs(target_value)
    return self if self.value == target_value
    
    self.children.each do |child|
      result = child.dfs(target_value)
      return result if result != nil
      
    end
    nil
  end
  
  def bfs(target_value)
    que = [self]
    while que.length != 0
      first = que.shift
      return first if first.value == target_value
      
      first.children.each do |child|
        que << child
      end
    end
    nil
      
  end
      
end