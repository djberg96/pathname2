require 'spec_helper'

RSpec.describe Pathname2, '#unc?' do
  let(:abs_path) { Pathname2.new("C:\\Program Files") }
  let(:unc_path) { Pathname2.new("\\\\foo\\bar\\baz") }
  let(:rel_path) { Pathname2.new("foo\\bar\\baz") }

  it 'has unc? method' do
    expect(unc_path).to respond_to(:unc?)
  end

  it 'returns boolean' do
    expect([true, false]).to include(unc_path.unc?)
  end

  it 'returns false for non-UNC paths' do
    expect(Pathname2.new("C:\\").unc?).to be false
    expect(Pathname2.new("C:\\Program Files").unc?).to be false
    expect(Pathname2.new("C:\\\\Program Files").unc?).to be false
    expect(Pathname2.new("C:/Program Files/File.txt").unc?).to be false
    expect(Pathname2.new("C:\\Program Files\\File[12].txt").unc?).to be false
    expect(Pathname2.new("foo\\bar").unc?).to be false
    expect(Pathname2.new(".").unc?).to be false
  end

  it 'returns true for UNC paths' do
    expect(Pathname2.new("\\\\foo\\bar").unc?).to be true
    expect(Pathname2.new("//foo/bar").unc?).to be true
    expect(Pathname2.new("\\\\foo\\bar\\baz").unc?).to be true
    expect(Pathname2.new("\\\\foo").unc?).to be true
    expect(Pathname2.new("\\\\").unc?).to be true
  end

  it 'is not destructive' do
    str = '//foo/bar'
    Pathname2.new(str).unc?
    expect(str).to eq('//foo/bar')
  end
end
