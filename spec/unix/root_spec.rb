require 'spec_helper'

RSpec.describe Pathname2, '#root' do
  let(:abs_path) { Pathname2.new('/usr/local/bin') }
  let(:rel_path) { Pathname2.new('usr/local/bin') }

  it 'has root method' do
    expect(abs_path).to respond_to(:root)
  end

  it 'returns "/" for absolute paths' do
    expect(abs_path.root).to eq('/')
  end

  it 'returns "." for relative paths' do
    expect(rel_path.root).to eq('.')
  end

  it 'does not modify the original path' do
    abs_path.root
    expect(abs_path).to eq('/usr/local/bin')

    rel_path.root
    expect(rel_path).to eq('usr/local/bin')
  end
end
