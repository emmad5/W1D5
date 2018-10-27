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


class KnightPathFinder
  attr_reader :start_pos
  
  def initialize(start_pos)
    @start_pos = start_pos
    @visited_positions = [start_pos]
    build_move_tree
  end
  
  def build_move_tree
    @root = PolyTreeNode.new(start_pos)
    new_node_que = [@root]
    
    while @visited_positions.length < 64 
      
      new_move_positions(new_node_que[0].value).each do |valid_pos|
        #iterate throught all chilren of the start visited_positions
          
          @visited_positions << valid_pos
          #adds valid_pos to visited_positions
          new_node = PolyTreeNode.new(valid_pos)
          #creates new node at each child of start position
          new_node.parent = new_node_que[0]
          #assign child to parent (start_pos)
          new_node_que << new_node
          #adds child to queue
        #removes root node (start_pos) from the beggining of the new_move_que
      end  
      new_node_que.shift
    end 
     
  end
  
  
  def new_move_positions(pos)
    KnightPathFinder.valid_moves(pos) - @visited_positions
    # eventually minus the moves that are outside the board
  end

  def self.valid_moves(pos)
    results = []
    array_two = [2, -2]
    array_one = [1, -1]
    array_two.each do |number2|
      array_one.each do |number1|
      results.push([number2, number1], [number1, number2])
      end
    end
    new_positions = []
    results.each do |move|
      new_pos = [pos[0] + move[0], pos[1] + move[1]]
      new_positions << new_pos if new_pos.all? { |coord| coord.between?(0, 7) }
    end
    new_positions
  end

  
  
end