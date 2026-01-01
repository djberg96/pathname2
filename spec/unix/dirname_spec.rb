require 'spec_helper'

RSpec.describe Pathname2, '#dirname' do
  let(:abs_path) { Pathname2.new('/usr/local/bin') }

  it 'has dirname method' do
    expect(abs_path).to respond_to(:dirname)
  end

  it 'returns string' do
    expect(abs_path.dirname).to be_a(String)
  end

  it 'returns parent directory' do
    expect(abs_path.dirname).to eq('/usr/local')
  end

  context 'with level parameter' do
    it 'returns same path with level 0' do
      expect(abs_path.dirname(0)).to eq('/usr/local/bin')
    end

    it 'returns parent directory with level 1' do
      expect(abs_path.dirname(1)).to eq('/usr/local')
    end

    it 'returns grandparent directory with level 2' do
      expect(abs_path.dirname(2)).to eq('/usr')
    end

    it 'returns root with level 3' do
      expect(abs_path.dirname(3)).to eq('/')
    end

    it 'returns root when level exceeds depth' do
      expect(abs_path.dirname(9)).to eq('/')
    end

    it 'raises error for negative levels' do
      expect { abs_path.dirname(-1) }.to raise_error(ArgumentError)
    end
  end
end
