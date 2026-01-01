require 'spec_helper'

RSpec.describe Pathname2, '#relative?' do
  let(:relative) { Pathname2.new("foo/bar") }
  let(:absolute) { Pathname2.new("C:/foo/bar") }

  it 'has relative? method' do
    expect(relative).to respond_to(:relative?)
  end

  it 'returns boolean' do
    expect([true, false]).to include(relative.relative?)
  end

  it 'returns true for relative paths' do
    expect(relative.relative?).to be true
  end

  it 'returns false for non-relative paths' do
    expect(absolute.relative?).to be false
    expect(Pathname2.new("//foo/bar").relative?).to be false
  end

  it 'returns true for empty path' do
    expect(Pathname2.new("").relative?).to be true
  end

  it 'is not destructive' do
    str = 'C:/foo'
    path = Pathname2.new(str)
    path.relative?
    expect(path.to_s).to eq('C:\foo')
    expect(str).to eq('C:/foo')
  end
end
