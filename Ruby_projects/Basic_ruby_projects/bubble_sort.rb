def bubble_sort(array)
  pass_throughs = 0
  compare = 0
  while pass_throughs < array.length
    while compare < array.length - 1
      if array[compare] > array[compare + 1]
        array[compare], array[compare + 1] = array[compare + 1], array[compare]
      end
      compare += 1
    end
    compare = 0
    pass_throughs += 1
   end
  array
end

# Unhide the below puts to test the bubble_sort method.
# puts bubble_sort([4,3,78,2,0,2])

def bubble_sort_by(array)
  pass_throughs = 0
  compare = 0
  while pass_throughs < array.length
    while compare < array.length - 1
      if yield(array[compare], array[compare + 1]) < 0
        array[compare], array[compare + 1] = array[compare + 1], array[compare]
      end
      compare += 1
    end
    compare = 0
    pass_throughs += 1
  end
  print array
end

bubble_sort_by = bubble_sort_by(["hi","hello","hey"]) do |left,right|
    left.length - right.length
    end

# Unhide the below puts to test the bubble_sort_by method.
# puts bubble_sort_by
