class Calculator
  def combinations_of input, target: 
    # input => [5, 5, 15, 10]
    # target => 15
    # value_map => {5=>[0, 1], 15=>[2], 10=>[3]}
    value_map = map_values_to_indexes input

    # unique_input => [5, 15, 10]
    unique_input = value_map.keys

    # combinations => [[15], [5, 10], [5, 10]]
    combinations = unique_input.size.times.flat_map do |size|
      possibles = unique_input.combination(size + 1)
      possibles.select{|set| sum(set) == target }
    end.reject(&:empty?)

    # index_sets => [[[2]], [[0, 1], [3]]]
    index_sets = combinations.uniq.map do |set|
      set.map{|match| value_map[match] }
    end

    index_sets.flat_map do |set|
      # set => [[[0, 1], [3]]]
      # combine_lists => [[0,3], [1,3]]]
      combine_lists set
    end
  end

  def sum set
    set.reduce(0, :+)
  end

  # set => [[[0, 1], [3]]]
  def combine_lists set
    # get all possible sets of the given values
    combinations = set.flatten.combination(set.size)
    # reject any that contain more than one value from a given list
    combinations.reject do |combination|
      min_size = combination.size - 1
      set.any? do |list|
        (combination - list).size < min_size
      end
    end
  end

  private

  def map_values_to_indexes input
    {}.tap do |table|
      input.each.with_index do |value, index|
        table[value] ||= []
        table[value] << index
      end
    end
  end
end
