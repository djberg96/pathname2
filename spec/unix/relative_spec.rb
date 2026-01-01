require 'spec_helper'

RSpec.describe Pathname2, '#relative?' do
  let(:abs_path) { Pathname2.new('/usr/local/bin') }
  let(:rel_path) { Pathname2.new('usr/local/bin') }

  it 'has relative? method' do
    expect(abs_path).to respond_to(:relative?)
  end

  it 'returns false for absolute paths' do
    expect(abs_path.relative?).to be false
    expect(Pathname2.new('/usr/bin/ruby').relative?).to be false
  end

  it 'returns true for relative paths' do
    expect(rel_path.relative?).to be true
    expect(Pathname2.new('foo').relative?).to be true
    expect(Pathname2.new('foo/bar').relative?).to be true
    expect(Pathname2.new('../foo/bar').relative?).to be true
  end

  it 'does not modify the original path' do
    abs_path.relative?
    expect(abs_path).to eq('/usr/local/bin')

    rel_path.relative?
    expect(rel_path).to eq('usr/local/bin')
  end
end
