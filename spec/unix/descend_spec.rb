require 'spec_helper'

RSpec.describe Pathname2, '#descend' do
  let(:abs_path) { Pathname2.new('/usr/local/bin') }
  let(:rel_path) { Pathname2.new('usr/local/bin') }

  it 'has descend method' do
    expect(abs_path).to respond_to(:descend)
  end

  it 'yields successive ancestor directories for absolute path' do
    abs_array = []
    abs_path.descend { |path| abs_array.push(path) }

    expect(abs_array[0]).to eq('/')
    expect(abs_array[1]).to eq('/usr')
    expect(abs_array[2]).to eq('/usr/local')
    expect(abs_array[3]).to eq('/usr/local/bin')
    expect(abs_array.length).to eq(4)
  end

  it 'yields successive ancestor directories for relative path' do
    rel_array = []
    rel_path.descend { |path| rel_array.push(path) }

    expect(rel_array[0]).to eq('usr')
    expect(rel_array[1]).to eq('usr/local')
    expect(rel_array[2]).to eq('usr/local/bin')
    expect(rel_array.length).to eq(3)
  end

  it 'does not modify the original path' do
    abs_path.descend {}
    expect(abs_path).to eq('/usr/local/bin')

    rel_path.descend {}
    expect(rel_path).to eq('usr/local/bin')
  end
end
