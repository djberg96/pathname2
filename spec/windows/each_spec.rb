require 'spec_helper'

RSpec.describe Pathname2, '#each' do
  let(:path) { Pathname2.new("C:/Users/foo/bar") }

  it 'has each method' do
    expect(path).to respond_to(:each)
  end

  it 'returns the expected results' do
    arr = []
    path.each { |e| arr << e }
    expect(arr).to eq(['C:', 'Users', 'foo', 'bar'])
  end
end
