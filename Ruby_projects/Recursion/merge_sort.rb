def merge_sort(array)
  return array if array.length <= 1
  split_array = array.length / 2
  left_array = merge_sort(array[0..split_array - 1])
  right_array = merge_sort(array[split_array..-1])
  print left_array
  print right_array 
  result = []
  while left_array.length != 0 && right_array.length != 0
    if left_array[0] > right_array[0]
      result << right_array[0]
      right_array.shift
    else
      result << left_array[0]
      left_array.shift
    end
  end
  result + left_array + right_array
end

merge_sort([3,1,67,9])