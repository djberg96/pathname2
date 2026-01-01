require 'spec_helper'

RSpec.describe Pathname2, '#long_path' do
  let(:abs_path) { Pathname2.new("C:\\PROGRA~1") }

  it 'has long_path method' do
    expect(abs_path).to respond_to(:long_path)
  end

  it 'returns a string' do
    expect(abs_path.long_path).to be_a(String)
  end

  it 'returns the expected result' do
    expect(abs_path.long_path).to eq("C:\\Program Files")
  end

  it 'returns the same string if already long' do
    expect(Pathname2.new("C:/Program Files").long_path).to eq("C:\\Program Files")
  end

  it 'fails if the path does not exist' do
    expect { Pathname2.new("C:/Bogus/AlsoBogus").long_path }.to raise_error(Errno::ESRCH)
  end

  it 'is not destructive' do
    str = 'C:/Program Files'
    Pathname2.new(str).long_path
    expect(str).to eq('C:/Program Files')
  end
end
