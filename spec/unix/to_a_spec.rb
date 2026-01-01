require 'spec_helper'

RSpec.describe Pathname2, '#to_a' do
  let(:abs_path) { Pathname2.new('/usr/local/bin') }
  let(:rel_path) { Pathname2.new('usr/local/bin') }

  it 'has to_a method' do
    expect(abs_path).to respond_to(:to_a)
  end

  it 'returns array for absolute path' do
    expect(abs_path.to_a).to be_a(Array)
    expect(abs_path.to_a).to eq(%w[usr local bin])
  end

  it 'returns array for relative path' do
    expect(rel_path.to_a).to be_a(Array)
    expect(rel_path.to_a).to eq(%w[usr local bin])
  end

  it 'does not modify the original path' do
    abs_path.to_a
    expect(abs_path).to eq('/usr/local/bin')

    rel_path.to_a
    expect(rel_path).to eq('usr/local/bin')
  end
end
