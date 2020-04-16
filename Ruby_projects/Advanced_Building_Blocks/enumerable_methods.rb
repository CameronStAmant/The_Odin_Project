# Unhide the commented out code, one line per run, to see it in action.

module Enumerable
  def my_each
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
  end

# [1, 2, 3, 4, 5].my_each { |a| puts a + 1}
# [1, 2, 3, 4, 5].each { |a| puts a + 1}

  def my_each_with_index
    i = 0
    while i < self.length
      yield(self[i], i)
      i += 1
    end
  end

# [1, 2, 3, 4, 5].my_each_with_index { |a, index| puts "#{index}: #{a + 1}"}
# [1, 2, 3, 4, 5].each_with_index { |a, index| puts "#{index}: #{a + 1}"}

  def my_select
    i = 0
    array = []
    while i < self.length
      if yield(self[i]) == true
        array << self[i]
      end
      i += 1
    end
    array
  end

# puts [1,2,3,4,5].my_select { |num|  num.even?  }
# puts [1,2,3,4,5].select { |num|  num.even?  }

  def my_all?
    i = 0
    while i < self.length
      if yield(self[i]) == false
        i = self.length + 1
        break
      end
      i += 1
    end
    if i == self.length
      puts "true"
    else
      puts "false"
    end
  end
  
# puts %w[ant bear cat].my_all? { |word| word.length >= 3 }
# puts  %w[ant bear cat].my_all? { |word| word.length >= 4 }
# puts  %w[ant bear cat].all? { |word| word.length >= 3 }
# puts  %w[ant bear cat].all? { |word| word.length >= 4 }


  def my_any?(type = nil)
    i = 0
    while i < self.length
      if type == nil
        if yield(self[i]) == true
          i = self.length + 1
          break
        end
        i += 1
      else
        self.my_each { |a| a.is_a?(Integer) ? i = self.length + 1 : i += 1}
      end
    end
    if i > self.length
      puts "true"
    else
      puts "false"
    end
  end
# puts %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# puts [nil, true, "a"].my_any?(Integer)
# puts %w[ant bear cat].any? { |word| word.length >= 4 } #=> true
# puts [nil, true, "a"].my_any?(Integer) #=> false



  def my_none?
    i = 0
    while i < self.length
      if yield(self[i]) == true
        i = self.length + 1
        break
      end
      i += 1
    end
    if i == self.length
      puts "true"
    else
      puts "false"
    end
  end

# puts %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
# puts %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
# puts %w{ant bear cat}.none? { |word| word.length == 5 } #=> true
# puts %w{ant bear cat}.none? { |word| word.length >= 4 } #=> false


#my_count
  def my_count(count = nil)
    i = 0
    tally = 0
    while i < self.length
      if block_given?
        if yield(self[i]) == true
          tally += 1
        end
      elsif count != nil
        if self[i] == count
          tally += 1
        end
      else
        tally = self.length
      end
      i += 1
    end
    puts tally
  end


# puts [1, 2, 4, 2].my_count               #=> 4
# puts [1, 2, 4, 2].my_count(2)            #=> 2
# puts [1, 2, 4, 2].my_count{ |x| x%2==0 } #=> 3
# puts [1, 2, 4, 2].count               #=> 4
# puts [1, 2, 4, 2].count(2)            #=> 2
# puts [1, 2, 4, 2].count{ |x| x%2==0 } #=> 3



  def my_map(myproc = nil)
    array = self.to_a
    array1 = []
    array.my_each { |a| array1 << (myproc ? myproc.call(a) : yield(a)) }
    print array1
  end

# print (1..4).my_map { |i| i*i }      #=> [1, 4, 9, 16]
# print (1..4).my_map { "cat"  }   #=> ["cat", "cat", "cat", "cat"]
# puts (1..4).map { |i| i*i }      #=> [1, 4, 9, 16]
# puts (1..4).map { "cat"  }   #=> ["cat", "cat", "cat", "cat"]

# Proc
# my_proc = Proc.new { |x| x ** x}
# (1..4).my_map(&my_proc)



  def my_inject(memo = nil, element = nil)
    array = self.to_a
    result = 0
    if block_given?
      array.my_each { |b| result = yield(result, b) }
    end
    if memo == :+
      array.my_each { |b| result += b }
    elsif memo == :-
      array.my_each { |b| result -= b }
    end
    if memo.is_a?(Integer)
      result += memo
      if element == :*
        array.my_each { |b| result *= b }
      elsif element == :/
        array.my_each { |b| result /= b }
      end
    end
    print result
  end

# puts (5..10).my_inject(:+) #=> 45
# puts (5..10).my_inject(1, :*) #=> 151200
# puts (5..10).my_inject { |sum, n| sum + n } #=> 45

# puts (5..10).inject(:+) #=> 45
# puts (5..10).inject(1, :*) #=> 151200
# puts (5..10).inject { |sum, n| sum + n } #=> 45


  def multiply_els(*ary)
    puts my_inject(1, :*)
  end

# [2,4,5].multiply_els #=> 40

end
