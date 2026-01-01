require 'spec_helper'

RSpec.describe Pathname2, '#parent' do
  let(:abs_path) { Pathname2.new('/usr/local/bin') }
  let(:rel_path) { Pathname2.new('usr/local/bin') }

  it 'has parent method' do
    expect(abs_path).to respond_to(:parent)
  end

  it 'returns parent directory for absolute path' do
    expect(abs_path.parent).to eq('/usr/local')
  end

  it 'returns parent directory for relative path' do
    expect(rel_path.parent).to eq('usr/local')
  end

  it 'returns "/" for root directory' do
    expect(Pathname2.new('/').parent).to eq('/')
  end
end
