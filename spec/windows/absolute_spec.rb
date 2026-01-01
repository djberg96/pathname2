require 'spec_helper'

RSpec.describe Pathname2, '#absolute?' do
  let(:abs_std) { Pathname2.new("C:/foo/bar/baz") }
  let(:abs_unc) { Pathname2.new("//foo/bar/baz") }

  it 'has absolute? method' do
    expect(abs_std).to respond_to(:absolute?)
  end

  it 'returns boolean' do
    expect([true, false]).to include(abs_std.absolute?)
  end

  it 'returns true for absolute paths' do
    expect(abs_std.absolute?).to be true
    expect(abs_unc.absolute?).to be true
  end

  it 'returns false for non-absolute paths' do
    expect(Pathname2.new("foo").absolute?).to be false
    expect(Pathname2.new("foo/bar").absolute?).to be false
  end

  it 'returns false for empty path' do
    expect(Pathname2.new("").absolute?).to be false
  end

  it 'is not destructive' do
    str = 'C:/foo'
    path = Pathname2.new(str)
    path.absolute?
    expect(path.to_s).to eq('C:\foo')
    expect(str).to eq('C:/foo')
  end
end
