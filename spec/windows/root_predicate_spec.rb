require 'spec_helper'

RSpec.describe Pathname2, '#root?' do
  let(:std_root) { Pathname2.new("C:\\") }
  let(:unc_root) { Pathname2.new("\\\\foo\\bar") }

  it 'has root? method' do
    expect(std_root).to respond_to(:root?)
  end

  it 'returns boolean' do
    expect([true, false]).to include(std_root.root?)
  end

  it 'returns true for root paths' do
    expect(std_root.root?).to be true
    expect(unc_root.root?).to be true
  end

  it 'returns false for non-root paths' do
    expect(Pathname2.new("C:/foo").root?).to be false
    expect(Pathname2.new("//foo/bar/baz").root?).to be false
    expect(Pathname2.new("").root?).to be false
  end

  it 'is not destructive' do
    str = 'C:/foo'
    path = Pathname2.new(str)
    path.root
    expect(path.to_s).to eq('C:\foo')
    expect(str).to eq('C:/foo')
  end
end
