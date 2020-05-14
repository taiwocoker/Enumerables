# rubocop: disable Metrics/ModuleLength
# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    for i in self
      yield i
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = 0
    for i in self
      yield i, index
      index += 1
    end
  end


  def my_select
    return to_enum(:my_select) unless block_given?

    if is_a?(Array)
      arr = []
      my_each do |num|
        arr << num if yield(num)
      end
      arr
    elsif is_a?(Hash)
      hash = {}
      my_each do |key, val|
        hash[key] = val if yield(key, val)
      end
      hash
    end
  end

  def my_all?
    return to_enum(:my_all) unless block_given?

    result = my_select { |x| yield x }

    length == result.length
  end

  def my_any?
    return to_enum(:my_any) unless block_given?

    result = my_select { |x| yield x }

    result.length.positive?
  end

  def my_none?
    return to_enum(:my_none) unless block_given?

    !my_any?
  end

  def my_count(count = nil)
    return count if count
    return length unless block_given?

    my_select { |x| yield x }.length
  end

  def my_map(my_proc = nil)
    array = []
    my_each { |x| array << my_proc.call(x) } if my_proc
    my_each { |x| array << yield(x) } if block_given?

    array
  end

  def my_inject(accumulator = nil, operation = nil, &block)
    block = case operation
      when Symbol
        lambda { |acc, value| acc.send(operation, value) }
      when nil
        block
      else
      raise ArgumentError, "the operation provided must be a symbol"
    end
    if accumulator.nil?
      ignore_first = true
      accumulator = first
    end
    index = 0
    each do |element|
      unless ignore_first && index == 0
        accumulator = block.call(accumulator, element)
      end
      index += 1
    end
    accumulator
  end


end




# rubocop: enable Metrics/ModuleLength
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity