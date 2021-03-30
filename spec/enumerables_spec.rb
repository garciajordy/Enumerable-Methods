require_relative '../enumerables.rb'

describe Enumerable do
  describe 'my_each method' do
    it 'returns empty array when collection is empty' do
      expected = []
      [].my_each { |item| expected << item }
      expect(expected).to eq([])
    end

    it 'returns each item in array when array is NOT empty' do
      array = [1, 2, 3]
      expected = []
      array.my_each { |item| expected << item }
      expect(expected).to eq(array)
    end

    it 'returns each item in a given range' do
      expected = []
      (1..3).my_each { |item| expected << item }
      expect(expected).to eq([1, 2, 3])
    end

    it 'returns an Enumerator when block is not passed in' do
      expect([1, 2, 3].my_each.class).to eq(Enumerator)
    end
  end
end