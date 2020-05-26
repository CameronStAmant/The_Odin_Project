require 'pry'

class Node
  attr_accessor :left_child, :right_child
  attr_reader :value
  
  def initialize(value)
    @value = value
    @left_child = nil
    @right_child = nil
  end

end

class Tree

  def initialize(array)
    @original = array.uniq
    build_tree(array)
    @level = [@root]
    @array_size = 0
    @depth = 0
    @height_array = []
    @counter = 0
    @balance_counter = 0
    @balance_counter_2 = 0
    @balanced = 0
  end

  def build_tree(array)
    array.sort!
    @root = Node.new(array[(array.size)/2])
    array.delete(array[(array.size)/2])
    p @root
    @tree = array.each { |x| add_node(@root, x)}
  end

  def add_node(node, value)
    if value > node.value
      if node.right_child
        add_node(node.right_child, value)
      else
        node.right_child = Node.new(value)
      end
    else
      if node.left_child
        add_node(node.left_child, value)
      else
        node.left_child = Node.new(value)
      end
    end
  end

  def insert(value)
    add_node(@root, value)
    @original << value
  end

  def delete(value, node=@root)
    if value == node.value
      puts "The root node has been deleted, resulting in the entire tree being deleted."
      exit
    end
    if node.left_child.nil?
    else
      if value == node.left_child.value
        @original.delete(value)
        p build_tree(@original)
        return
      end
    end
    if node.right_child.nil?
    else
      if value == node.right_child.value
        @original.delete(value)
        p build_tree(@original)
        return
      end
    end
    if value < node.value && node.left_child == nil
      puts "#{value} is not within the tree. 1"
    elsif value < node.value
      delete(value, node.left_child)
    elsif value > node.value && node.right_child == nil
      puts "#{value} is not within the tree. 2"
    elsif value > node.value
      delete(value, node.right_child)
    else
      puts "#{value} is not within the tree. 3"
    end
  end

  def find(value, node=@root)
    if value == node.value
      puts node
      return
    end
    if node.left_child.nil?
    else
      if value == node.left_child.value
        @depth += 1
        puts node.left_child
        return 
      end
    end
    if node.right_child.nil?
    else
      if value == node.right_child.value
        @depth += 1
        puts node.right_child
        return
      end
    end
    @depth += 1
    if value < node.value && node.left_child == nil
      puts "#{value} is not within the tree."
    elsif value < node.value
      find(value, node.left_child)
    elsif value > node.value && node.right_child == nil
      puts "#{value} is not within the tree."
    elsif value > node.value
      find(value, node.right_child)
    else
      puts "#{value} is not within the tree."
    end
  end

  def level_order(node=@root, array_size=0, &block)
    if @array_size < @original.size
      if @counter <= @balance_counter
        if node.nil?
          return
        end
        if node.left_child != nil
          @level << node.left_child
          if @balance_counter_2 == 1
            @height_array << node.left_child
          end
        end
        if node.right_child != nil
          @level << node.right_child
          if @balance_counter_2 == 1
            @height_array << node.right_child
          end
        end
        if @balance_counter_2 == 1
          if @height_array.size != 0
            @counter += 1
            if @height_array[@counter].nil?
              nil
            end
            level_order(@height_array[@counter])
          end
        end
        if block_given?
          yield(@level[0].value)
        end
        @level.shift
        @array_size += 1
        level_order(@level[0], array_size, &block)
      end
    end
  end

  def preorder(node=@root, &block)
    if node.nil?
      return
    end
    if block_given?
      yield(node.value)
    end
    @balance_counter += 1
    preorder(node.left_child, &block)
    preorder(node.right_child, &block)
  end

  def inorder(node=@root, &block)
    if node.nil?
      return
    end
    inorder(node.left_child, &block)
    yield(node.value)
    inorder(node.right_child, &block)
  end

  def postorder(node=@root, &block)
    if node.nil?
      return
    end
    postorder(node.left_child, &block)
    postorder(node.right_child, &block)
    yield(node.value)
  end

  def depth(x)
    find(x)
    puts @depth
  end

  def balanced?
    @array_size = 0
    @balance_counter_2 = 1
    @counter = 0
    @depth = 0
    @balance_counter = 0
    @height_array = [@root.left_child]
    preorder(@root.left_child)
    @balance_counter -= 1
    level_order(@root.left_child)
    if @height_array[0].nil?
      left_height = 0
      @height_array << Node.new("nil")
    else
      depth(@height_array[-1].value)
      left_height = @depth
    end
    p "The left tree is #{left_height} levels deep, with the last number being #{@height_array[-1].value}"
    puts
    @array_size = 0
    @counter = 0
    @depth = 0
    @balance_counter = 0
    @height_array = [@root.right_child]
    preorder(@root.right_child)
    @balance_counter -= 1
    level_order(@root.right_child)
    if @height_array[0].nil?
      right_height = 0
      @height_array << Node.new("nil")
    else
      depth(@height_array[-1].value)
      right_height = @depth
    end
    p "The right tree is #{right_height} levels deep, with the last number being #{@height_array[-1].value}"
    if left_height + 1 == right_height || left_height == right_height || left_height - 1 == right_height
      puts "balanced"
      @balanced = 1
    else
      puts "not balanced"
    end
  end

  def rebalance!
    a = @original
    build_tree(a)
  end

end

Tree1 = Tree.new(Array.new(15) { rand(1..100) })
Tree1.balanced?
p Tree1.level_order
puts
p Tree1.preorder { |x| puts x }
puts
p Tree1.postorder { |x| puts x }
puts
p Tree1.inorder { |x| puts x }
puts
puts
Tree1.insert(101)
Tree1.insert(102)
Tree1.insert(103)
Tree1.insert(104)
Tree1.insert(105)
Tree1.insert(106)
Tree1.balanced?
puts
puts
Tree1.rebalance!
puts
puts
Tree1.balanced?
puts
p Tree1.preorder { |x| puts x }
puts
p Tree1.postorder { |x| puts x }
puts
p Tree1.inorder { |x| puts x }
