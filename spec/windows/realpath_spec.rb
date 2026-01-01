require 'spec_helper'

RSpec.describe Pathname2, '#realpath' do
  let(:cwd) { Dir.pwd.tr('/', "\\") }
  let(:path) { Pathname2.new(Dir.pwd) }

  it 'has realpath method' do
    expect(path).to respond_to(:realpath)
  end

  it 'returns a string' do
    expect(path.realpath).to be_a(String)
  end

  it 'returns the expected result' do
    expect(path.realpath).to eq(cwd)
  end

  it 'fails if the path does not exist' do
    expect { Pathname2.new("C:/Bogus/AlsoBogus").realpath }.to raise_error(Errno::ENOENT)
  end

  it 'is not destructive' do
    str = 'C:/Program Files'
    Pathname2.new(str).realpath
    expect(str).to eq('C:/Program Files')
  end
end
