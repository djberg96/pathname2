require 'spec_helper'

RSpec.describe Pathname2, '#descend' do
  let(:path) { Pathname2.new("C:\\foo\\bar\\baz") }

  it 'has descend method' do
    expect(path).to respond_to(:descend)
  end

  it 'works on standard absolute paths' do
    array = []
    path.descend { |e| array << e }
    expect(array[0]).to eq('C:')
    expect(array[1]).to eq('C:\foo')
    expect(array[2]).to eq('C:\foo\bar')
    expect(array[3]).to eq('C:\foo\bar\baz')
  end

  it 'works on UNC paths' do
    array = []
    Pathname2.new('//foo/bar/baz').descend { |e| array << e }
    expect(array[0]).to eq("\\\\foo\\bar")
    expect(array[1]).to eq("\\\\foo\\bar\\baz")
  end

  it 'works on relative paths' do
    array = []
    Pathname2.new('foo/bar/baz').descend { |e| array << e }
    expect(array[0]).to eq('foo')
    expect(array[1]).to eq('foo\bar')
    expect(array[2]).to eq('foo\bar\baz')
  end

  it 'does not modify the receiver' do
    path.descend {}
    expect(path).to eq('C:\foo\bar\baz')
  end
end
