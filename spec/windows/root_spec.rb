require 'spec_helper'

RSpec.describe Pathname2, '#root' do
  let(:abs_path) { Pathname2.new("C:\\Program Files") }
  let(:unc_path) { Pathname2.new("\\\\foo\\bar\\baz") }
  let(:rel_path) { Pathname2.new("foo\\bar\\baz") }

  it 'returns expected results for absolute paths' do
    expect(abs_path.root).to eq("C:\\")
  end

  it 'returns expected results for paths with forward slashes' do
    expect(Pathname2.new("C:/Program Files").root).to eq("C:\\")
  end

  it 'returns expected results for UNC paths' do
    expect(unc_path.root).to eq("\\\\foo\\bar")
    expect(Pathname2.new("\\\\foo").root).to eq("\\\\foo")
    expect(Pathname2.new("\\\\").root).to eq("\\\\")
  end

  it 'returns dot for relative paths' do
    expect(rel_path.root).to eq('.')
  end

  it 'returns expected result for root path' do
    expect(Pathname2.new("Z:\\").root).to eq("Z:\\")
    expect(Pathname2.new("\\\\foo\\bar").root).to eq("\\\\foo\\bar")
  end

  it 'returns expected result for empty string' do
    expect(Pathname2.new("").root).to eq(".")
  end

  it 'returns expected result for dot and dotdot' do
    expect(Pathname2.new("..").root).to eq(".")
    expect(Pathname2.new(".").root).to eq(".")
  end

  it 'is not destructive' do
    str = 'C:/Program Files'
    Pathname2.new(str).root
    expect(str).to eq('C:/Program Files')
  end
end
