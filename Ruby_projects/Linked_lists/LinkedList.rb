class LinkedList
  attr_accessor :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    value = Node.new(value)

    @head.nil? ? @head = value : @tail.next_node = value
    @tail = value
    @size += 1
  end

  def prepend(value)
    value = Node.new(value)
    value.next_node = @head
    @head = value
    @size += 1

  end

  def size
    puts @size
  end

  def head
    puts "#{@head} #{@head.value} #{@head.next_node} #{@head.next_node.value}"
  end

  def tail
    puts "#{@tail} #{@tail.value} #{@tail.next_node}"
  end

  def at(index)
    counter = 0
    node = @head
    while counter != index
      node = node.next_node
      counter += 1
    end
    node
  end

  def pop
    @tail = at(@size - 2)
    @tail.next_node = nil
    @size -= 1
  end

  def contains?(value)
    
    index = 0

    return false if index >= @size

    return true if at(index).value == value

    contains?(value, index + 1)
  end

  def find(value)
    
    index = 0

    return nil if index >= @size

    while index < @size
      if at(index).value == value
        return index
      else
        index += 1
      end
    end
    nil
  end

  def to_s
    counter = 0
    node = @head
    string = ""
    node = @head
    while counter != @size
      at(counter)
      string += "( #{node.value} ) -> "
      counter += 1
      node = node.next_node
    end
    string += "nil"
    string
  end

end

class Node
  attr_accessor :value, :next_node
  
  def initialize(value=nil, next_node=nil)
    @value = value
    @next_node = next_node
  end

end

