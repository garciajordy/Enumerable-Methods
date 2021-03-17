# enumerable.rb
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
    new_array = []
    to_a.my_each { |item| new_array.push(item) if yield(item) }
    new_array
  end

  def my_all?
    to_a.my_each { |item| return false if yield(item) == false }
    true
  end

  def my_any?
    to_a.my_each { |item| return true if yield(item) }
    false
  end

  def my_none?
    to_a.my_each { |item| return false if yield(item) }
    true
  end

  def my_count?
    i = 0
    to_a.my_each { |_item| i += 1 }
    i
  end

  def my_map(proc = nil)
    new_array = []
    if proc.nil?
      to_a.my_each { |item| new_array << yield(item) }

    else
      to_a.my_each { |item| new_array << proc.call(item) }
    end
    new_array
  end

  def my_inject
    sum = 0
    to_a.my_each { |item| sum = yield(sum, item) }
    return sum if sum != 0

    sum = 1
    to_a.my_each { |item| sum = yield(sum, item) }
    sum
  end
end
