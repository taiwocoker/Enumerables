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

end

arr=[1,2,3,4,5,6]

p arr.my_each
p arr.each


# rubocop: enable Metrics/ModuleLength
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity