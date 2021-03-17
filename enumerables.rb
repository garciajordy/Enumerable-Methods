module Enumerable

    def my_each
    i = 0 
    while to_a.length > i
      yield(to_a[i])
      i += 1
    end
    end
    
    def my_each_with_index
    i = 0
    while to_a.length > i
      yield(to_a[i], i)
      i += 1
    end
    end
    
    def my_select
    newArray = [] 
    to_a.my_each{|item|newArray.push(item) if yield(item)}
    return newArray
    end
    
    def my_all?
    to_a.my_each{|item|return false if yield(item) == false}
    return true
    end
    def my_any?
    to_a.my_each{|item|return true if yield(item) }
    return false
    end