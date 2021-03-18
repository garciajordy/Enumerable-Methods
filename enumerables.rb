# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
module Enumerable
  def my_each
    i = 0
    return to_enum unless block_given?

    while to_a.length > i
      yield(to_a[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    return to_enum unless block_given?

    while to_a.length > i
      yield(to_a[i], i)
      i += 1
    end
    self
  end

  def my_select
    new_array = []
    return to_enum unless block_given?

    to_a.my_each { |item| new_array.push(item) if yield(item) }
    new_array
  end

  def my_all?(params = nil)
    if block_given?
      to_a.my_each { |item| return false if yield(item) == false }
    elsif params.nil?
      to_a.my_each { |item| return false if item.nil? || item == false }
    elsif !params.nil? && (params.is_a? Class)
      to_a.my_each { |item| return false unless [item.class, item.class.superclass].include?(params) }
    elsif !params.nil? && params.instance_of?(Regexp)
      to_a.my_each { |item| return false unless item.match(params) }
    else
      to_a.my_each { |item| return false if item != params }
    end
    true
  end

  def my_any?(params = nil)
    if block_given?
      to_a.my_each { |item| return true if yield(item) }
      return false
    elsif params.nil?
      to_a.my_each { |item| return true if item }
    elsif !params.nil? && (params.is_a? Class)
      to_a.my_each { |item| return true if [item.class,item.class.superclass].include?(params) }
    elsif !params.nil? && params.instance_of?(Regexp)
      to_a.my_each { |item| return true if item.match(params) }
    else
      to_a.my_each { |item| return true if item == params }
    end
    false
  end

  def my_none?(params = nil)
    if block_given?
      !my_any?(&Proc.new)
    else
      !my_any?(params)
    end
  end

  def my_count(params = nil)
    i = 0
    if params.nil? && !block_given?
      to_a.my_each { |_item| i += 1 }
    elsif !params.nil?
      to_a.my_each { |item| i += 1 if item == params }
    else
      to_a.my_each { |item| i += 1 if yield(item) }
    end
    i
  end

  def my_map(proc = nil)
    return to_enum unless block_given? || !proc.nil?

    new_array = []
    if proc.nil?
      to_a.my_each { |item| new_array << yield(item) }

    else
      to_a.my_each { |item| new_array << proc.call(item) }
    end
    new_array
  end

  def my_inject(value = nil, symbol = nil)
    if (!value.nil? && symbol.nil?) && (value.is_a?(Symbol) || value.is_a?(String))
      symbol = value
      value = nil
    end
    if !block_given? && !symbol.nil?
      to_a.my_each { |item| value = value.nil? ? item : value.send(symbol, item) }
    else
      to_a.my_each { |item| value = value.nil? ? item : yield(value, item) }
    end
    value
  end
end
# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

def multiply_els(arr)
  arr.my_inject(:*)
end
