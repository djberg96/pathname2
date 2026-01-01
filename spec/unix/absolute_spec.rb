require 'spec_helper'

RSpec.describe Pathname2, '#absolute?' do
  let(:abs_path) { Pathname2.new('/usr/local/bin') }
  let(:rel_path) { Pathname2.new('usr/local/bin') }

  it 'has absolute? method' do
    expect(abs_path).to respond_to(:absolute?)
  end

  it 'returns true for absolute paths' do
    expect(abs_path.absolute?).to be true
    expect(Pathname2.new('/usr/bin/ruby').absolute?).to be true
  end

  it 'returns false for relative paths' do
    expect(rel_path.absolute?).to be false
    expect(Pathname2.new('foo').absolute?).to be false
    expect(Pathname2.new('foo/bar').absolute?).to be false
    expect(Pathname2.new('../foo/bar').absolute?).to be false
  end

  it 'does not modify the original path' do
    abs_path.absolute?
    expect(abs_path).to eq('/usr/local/bin')

    rel_path.absolute?
    expect(rel_path).to eq('usr/local/bin')
  end
end
