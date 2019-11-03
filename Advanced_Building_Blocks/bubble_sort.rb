def bubble_sort(array)
    i = 0
    while array != array.sort
        if array[i + 1].is_a? Integer
            #print array
            #puts
            if array[i] > array[i + 1]
                array[i], array[i + 1] = array[i + 1], array[i]
                i += 1
            else 
                #print array
                #puts
                i += 1
            end
        else
            i = 0
        end
    end
    print array
end

bubble_sort([4,3,78,2,0,2])
