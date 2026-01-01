require 'spec_helper'

RSpec.describe Pathname2, '#to_a' do
  let(:path) { Pathname2.new('C:/Program Files/foo') }

  it 'has to_a method' do
    expect(path).to respond_to(:to_a)
  end

  it 'returns an array' do
    expect(path.to_a).to be_a(Array)
  end

  it 'returns the expected results for standard paths' do
    expect(Pathname2.new('C:/').to_a).to eq(['C:'])
    expect(Pathname2.new('C:/Program Files').to_a).to eq(['C:', 'Program Files'])
    expect(Pathname2.new('C:/Program Files/Stuff').to_a).to eq(['C:', 'Program Files', 'Stuff'])
    expect(Pathname2.new("C:\\Users").to_a).to eq(['C:', 'Users'])
  end

  it 'returns the expected results for UNC paths' do
    expect(Pathname2.new('//foo/bar/baz').to_a).to eq(['foo', 'bar', 'baz'])
    expect(Pathname2.new('//foo/bar').to_a).to eq(['foo', 'bar'])
    expect(Pathname2.new('//foo').to_a).to eq(['foo'])
  end

  it 'returns the expected results for empty strings and empty UNC paths' do
    expect(Pathname2.new('').to_a).to eq([])
    expect(Pathname2.new('//').to_a).to eq([])
  end

  it 'does not modify receiver' do
    path.to_a
    expect(path).to eq('C:\Program Files\foo')
  end
end
