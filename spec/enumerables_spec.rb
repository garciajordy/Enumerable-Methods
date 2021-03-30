require_relative '../enumerables.rb'

describe Enumerable do
  describe 'my_each method' do
    it 'yields no item when collection is empty' do
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

    it 'returns an Enumerator when block is not given' do
      expect([1, 2, 3].my_each.class).to eq(Enumerator)
    end
  end

  describe 'my_each_with_index method' do
    it 'yields no item when collection is empty' do
      expected = {}
      [].my_each_with_index { |item, index| expected[index.to_s] = item }
      expect(expected).to eq({})
    end

    it "yields each item (with it's index) in an array when array is NOT empty" do
      expected = {}
      [1, 2, 3].my_each_with_index { |item, index| expected[index.to_s] = item}
      expect(expected).to eq({ '0' => 1, '1' => 2, '2' => 3 })
    end

    it "yields each item (with it's index) in a given range" do
      expected = {}
      (1..3).my_each_with_index { |item, index| expected[index.to_s] = item }
      expect(expected).to eq({ '0' => 1, '1' => 2, '2' => 3 })
    end

    it 'returns an Enumerator when block is not given' do
      expect([1, 2, 3].my_each_with_index.class).to eq(Enumerator)
    end
  end
end