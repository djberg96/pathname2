require 'spec_helper'

RSpec.describe Pathname2, '#undecorate' do
  let(:std) { Pathname2.new('C:/Path/File.txt') }

  it 'has undecorate method' do
    expect(std).to respond_to(:undecorate)
  end

  it 'returns a Pathname2 object' do
    expect(std.undecorate).to be_a(Pathname2)
  end

  it 'returns an already undecorated path unchanged' do
    expect(Pathname2.new('C:\Path\File.txt').undecorate).to eq('C:\Path\File.txt')
    expect(Pathname2.new('\\foo\bar').undecorate).to eq('\\foo\bar')
  end

  it 'returns expected result for standard path' do
    expect(Pathname2.new('C:\Path\File[12]').undecorate).to eq('C:\Path\File')
    expect(Pathname2.new('C:\Path\[3].txt').undecorate).to eq('C:\Path\[3].txt')
  end

  it 'returns expected result for UNC path' do
    expect(Pathname2.new('\\foo\bar[5].txt').undecorate).to eq('\\foo\bar.txt')
    expect(Pathname2.new('\\foo\bar[5]').undecorate).to eq('\\foo\bar')
  end

  it 'does not modify the original string' do
    str = 'C:/Path/File.txt'
    Pathname2.new(str).undecorate
    expect(str).to eq('C:/Path/File.txt')
  end
end
