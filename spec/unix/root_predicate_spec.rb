require 'spec_helper'

RSpec.describe Pathname2, '#root?' do
  let(:abs_path) { Pathname2.new('/usr/local/bin') }
  let(:rel_path) { Pathname2.new('usr/local/bin') }

  it 'has root? method' do
    expect(abs_path).to respond_to(:root?)
  end

  it 'returns true for root path' do
    path = Pathname2.new('/')
    expect(path.root?).to be true
  end

  it 'returns false for non-root absolute path' do
    expect(abs_path.root?).to be false
  end

  it 'returns false for relative path' do
    path = Pathname2.new('a')
    expect(path.root?).to be false
  end

  it 'does not modify the original path' do
    abs_path.root?
    expect(abs_path).to eq('/usr/local/bin')

    rel_path.root?
    expect(rel_path).to eq('usr/local/bin')
  end
end
