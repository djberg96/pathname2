require 'spec_helper'

RSpec.describe Pathname2, '#[]' do
  let(:path) { Pathname2.new("C:/Program Files/Windows NT/Accessories") }

  describe 'with index' do
    it 'returns expected elements' do
      expect(path[0]).to eq("C:")
      expect(path[1]).to eq("Program Files")
      expect(path[-1]).to eq("Accessories")
      expect(path[10]).to be_nil
    end
  end

  describe 'with range' do
    it 'returns expected subpaths' do
      expect(path[0..1]).to eq("C:\\Program Files")
      expect(path[0..2]).to eq("C:\\Program Files\\Windows NT")
      expect(path[1..2]).to eq("Program Files\\Windows NT")
    end
  end

  describe 'with index and length' do
    it 'returns expected subpaths' do
      expect(path[0, 1]).to eq("C:")
      expect(path[0, 2]).to eq("C:\\Program Files")
      expect(path[1, 2]).to eq("Program Files\\Windows NT")
    end
  end
end
