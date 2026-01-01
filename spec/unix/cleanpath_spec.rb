require 'spec_helper'

RSpec.describe Pathname2, '#cleanpath' do
  it 'cleans standard paths' do
    expect(Pathname2.new('/a/b/c').cleanpath).to eq('/a/b/c')
    expect(Pathname2.new('./b/c').cleanpath).to eq('b/c')
    expect(Pathname2.new('a/.').cleanpath).to eq('a')
    expect(Pathname2.new('a/./c').cleanpath).to eq('a/c')
    expect(Pathname2.new('a/b/.').cleanpath).to eq('a/b')
    expect(Pathname2.new('a/../.').cleanpath).to eq('.')
    expect(Pathname2.new('/a/b/..').cleanpath).to eq('/a')
    expect(Pathname2.new('/a/../b').cleanpath).to eq('/b')
    expect(Pathname2.new('a/../../d').cleanpath).to eq('d')
  end

  it 'handles edge cases' do
    expect(Pathname2.new('').cleanpath).to eq('')
    expect(Pathname2.new('.').cleanpath).to eq('.')
    expect(Pathname2.new('..').cleanpath).to eq('..')
    expect(Pathname2.new('/').cleanpath).to eq('/')
    expect(Pathname2.new('//').cleanpath).to eq('/')
  end

  it 'does not modify the original path' do
    path = Pathname2.new('/usr/local/bin')
    path.cleanpath
    expect(path).to eq('/usr/local/bin')
  end
end
