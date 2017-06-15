require 'calculator'

RSpec.describe Calculator do
  let(:calculator) { Calculator.new }

  context 'combining sets of integers for a desired total' do
    # .combination makes no guarantees about output order,
    # so to ensure consistent output for specs, we need to sort
    def sorted_combinations_of input, target:
      calculator.combinations_of(input, target: target).sort_by(&:first).map(&:sort)
    end

    # need more verbose test output for demonstration purposes
    def verbosely_expect_combinations_of input:, target:, output:
      result = sorted_combinations_of(input, target: target)
      if ENV['VERBOSE']
        puts "combinations_of(#{input.inspect}, target: #{target}) => #{result.inspect}"
      end
      expect(result).to eq output
    end

    it 'should find the combinations for lists with duplicates' do
      verbosely_expect_combinations_of input: [5, 5, 15, 10], target: 15, output: [[0,3], [1,3], [2]]
    end

    it 'should find the combinations for lists without duplicates' do
      verbosely_expect_combinations_of input: [1, 2, 3, 4], target: 6, output: [[0,1,2], [1,3]]
    end
    
    it 'should find the combinations for lists with many duplicates' do
      verbosely_expect_combinations_of input: [5, 5, 15, 10, 10], target: 15, output: [[0,3], [0,4], [1,3], [1,4], [2]]
    end

    it 'should find the combinations for lists with many values' do
      verbosely_expect_combinations_of input: [5, 5, 15, 10, 6, 4], target: 15, output: [[0,3], [0,4,5], [1,3], [1,4,5], [2]]
    end

    it 'should find the combinations for lists with negative numbers' do
      verbosely_expect_combinations_of input: [5, -5, 0, 3], target: 0, output: [[0, 1], [0, 1, 2], [2]]
    end

    it 'should find the combinations for lists with a negative target' do
      verbosely_expect_combinations_of input: [-5, -5, -15, -10, -6, -4], target: -15, output: [[0,3], [0,4,5], [1,3], [1,4,5], [2]]
    end

    it 'should find the combinations for lists that require a combination of all numbers' do
      verbosely_expect_combinations_of input: [1, 2, 3, 4], target: 10, output: [[0, 1, 2, 3]]
    end

    it 'should find the empty combination set for empty lists' do
      verbosely_expect_combinations_of input: [], target: 15, output: []
    end

    it 'should find the empty combination set for lists that do not have a valid combination' do
      verbosely_expect_combinations_of input: [1, 2, 3, 4], target: 42, output: []
    end
  end

  context 'combining lists' do
    it 'combines lists containing only no duplicates' do
      expect(calculator.combine_lists [[0], [3]]).to eq [[0, 3]]
    end

    it 'combines lists containing only one duplicate' do
      expect(calculator.combine_lists [[0, 1], [3]]).to eq [[0, 3], [1, 3]]
    end

    it 'combines lists containing two duplicates' do
      expect(calculator.combine_lists [[0, 1], [3,4]]).to eq [[0, 3], [0, 4], [1, 3], [1,4]]
    end

    it 'combines lists containing many duplicates' do
      expect(calculator.combine_lists [[0, 1], [3,4], [2,5]]).to eq [[0, 3, 2], [0, 3, 5], [0, 4, 2], [0, 4, 5], [1, 3, 2], [1, 3, 5], [1, 4, 2], [1, 4, 5]]
    end
  end

  context 'summing arrays' do
    it 'sums positive numbers' do
      expect(calculator.sum [1, 2, 3, 4]).to eq 10
    end

    it 'sums negative numbers' do
      expect(calculator.sum [-1, -2, -3, -4]).to eq(-10)
    end

    it 'sums a mix of positive and negative numbers' do
      expect(calculator.sum [-1, 2, -3, 4]).to eq 2
    end
  end
end
