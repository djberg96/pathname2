require 'spec_helper'

RSpec.describe Pathname2, '#ascend' do
  let(:path) { Pathname2.new("C:\\foo\\bar\\baz") }

  it 'has ascend method' do
    expect(path).to respond_to(:ascend)
  end

  it 'works on standard absolute paths' do
    array = []
    path.ascend { |e| array << e }
    expect(array[0]).to eq('C:\foo\bar\baz')
    expect(array[1]).to eq('C:\foo\bar')
    expect(array[2]).to eq('C:\foo')
    expect(array[3]).to eq('C:')
  end

  it 'works on UNC paths' do
    array = []
    Pathname2.new('//foo/bar/baz').ascend { |e| array << e }
    expect(array[0]).to eq("\\\\foo\\bar\\baz")
    expect(array[1]).to eq("\\\\foo\\bar")
  end

  it 'works on relative paths' do
    array = []
    Pathname2.new('foo/bar/baz').ascend { |e| array << e }
    expect(array[0]).to eq('foo\bar\baz')
    expect(array[1]).to eq('foo\bar')
    expect(array[2]).to eq('foo')
  end

  it 'does not modify the receiver' do
    path.ascend {}
    expect(path).to eq('C:\foo\bar\baz')
  end
end
