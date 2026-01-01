require 'spec_helper'

RSpec.describe Pathname2, '#parent' do
  let(:path) { Pathname2.new("C:\\foo\\bar\\baz") }

  it 'has parent method' do
    expect(path).to respond_to(:parent)
  end

  it 'returns a Pathname2 object' do
    expect(path.parent).to be_a(Pathname2)
  end

  it 'returns expected results for absolute paths' do
    expect(Pathname2.new("C:\\foo\\bar\\baz").parent).to eq("C:\\foo\\bar")
    expect(Pathname2.new("C:\\foo").parent).to eq("C:\\")
  end

  it 'returns expected results for relative paths' do
    expect(Pathname2.new("foo\\bar").parent).to eq("foo")
  end

  it 'returns root if already a root path' do
    expect(Pathname2.new("C:\\").parent).to eq("C:\\")
    expect(Pathname2.new("//foo/bar").parent).to eq("\\\\foo\\bar")
  end
end
