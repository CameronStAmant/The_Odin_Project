class Node
  attr_accessor :value, :child0, :child1, :child2, :child3, :child4, :child5, :child6, :child7
  attr_reader :parent

  def initialize(value, parent)
    @value = value
    @parent = parent
    @child0 = nil
    @child1 = nil
    @child2 = nil
    @child3 = nil
    @child4 = nil
    @child5 = nil
    @child6 = nil
    @child7 = nil
  end
end

class Board
  attr_reader :board
  
  def initialize
    @board = [
      [8,1], [8,2], [8,3], [8,4], [8,5], [8,6], [8,7], [8,8],
      [7,1], [7,2], [7,3], [7,4], [7,5], [7,6], [7,7], [7,8],
      [6,1], [6,2], [6,3], [6,4], [6,5], [6,6], [6,7], [6,8],
      [5,1], [5,2], [5,3], [5,4], [5,5], [5,6], [5,7], [5,8], 
      [4,1], [4,2], [4,3], [4,4], [4,5], [4,6], [4,7], [4,8],
      [3,1], [3,2], [3,3], [3,4], [3,5], [3,6], [3,7], [3,8],
      [2,1], [2,2], [2,3], [2,4], [2,5], [2,6], [2,7], [2,8],
      [1,1], [1,2], [1,3], [1,4], [1,5], [1,6], [1,7], [1,8]]
  end
end

class Knight

  def initialize
    @knight = "piece"
    @board = Board.new
    @potential_moves = [["+",2,"+",1],["+",1,"+",2],["-",1,"+",2],["-",2,"+",1],["-",2,"-",1],["-",1,"-",2],["+",1,"-",2],["+",2,"-",1]]
    @potential_move_queue = []
    @node
    @order = []
  end

  def move_generator(starting, ending)
      a = 0
      while a < 8
        if @potential_moves[a][0] == "+"
          b = starting.value[0] + @potential_moves[a][1] 
        else
          b = starting.value[0] - @potential_moves[a][1] 
        end
        if @potential_moves[a][2] == "+"
          c = starting.value[1] + @potential_moves[a][3]
        else
          c = starting.value[1] - @potential_moves[a][3]
        end
        d = [b,c]
        if @board.board.include? d
          if a == 0
            starting.child0 = Node.new(d, starting)
            @potential_move_queue << starting.child0
            if starting.child0.value == ending
              @node = starting.child0
              return
            end
          elsif a == 1
            starting.child1 = Node.new(d, starting)
            @potential_move_queue << starting.child1
            if starting.child1.value == ending
              @node = starting.child1
              return
            end
          elsif a == 2
            starting.child2 = Node.new(d, starting)
            @potential_move_queue << starting.child2
            if starting.child2.value == ending
              @node = starting.child2
              return
            end
          elsif a == 3
            starting.child3 = Node.new(d, starting)
            @potential_move_queue << starting.child3
            if starting.child3.value == ending
              @node = starting.child3
              return
            end
          elsif a == 4
            starting.child4 = Node.new(d, starting)
            @potential_move_queue << starting.child4
            if starting.child4.value == ending
              @node = starting.child4
              return
            end
          elsif a == 5
            starting.child5 = Node.new(d, starting)
            @potential_move_queue << starting.child5
            if starting.child5.value == ending
              @node = starting.child5
              return
            end
          elsif a == 6
            starting.child6 = Node.new(d, starting)
            @potential_move_queue << starting.child6
            if starting.child6.value == ending
              @node = starting.child6
              return
            end
          else
            starting.child7 = Node.new(d, starting)
            @potential_move_queue << starting.child7
            if starting.child7.value == ending
              @node = starting.child7
              return
            end
          end
        end
        a += 1
      end
    @potential_move_queue.shift
    move_generator(@potential_move_queue[0], ending)
  end

  def knight_moves(starting, ending)
    @root = Node.new(starting, nil)
    @potential_move_queue << @root
    puts move_generator(@root, ending)
    puts
    while @node.parent != nil
      @order << @node.value
      @node = @node.parent
    end
    @order << @root.value
    puts "You finished in #{@order.size - 1} turns! Your sequence was"
    @order.reverse!.each do |x|
      p x
    end
    puts
  end
end

player = Knight.new
player.knight_moves([3,3], [4,3])
