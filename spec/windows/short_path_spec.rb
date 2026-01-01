require 'spec_helper'

RSpec.describe Pathname2, '#short_path' do
  let(:abs_path) { Pathname2.new("C:\\Program Files") }

  it 'has short_path method' do
    expect(abs_path).to respond_to(:short_path)
  end

  it 'returns a string' do
    expect(abs_path.short_path).to be_a(String)
  end

  it 'returns the expected result' do
    expect(abs_path.short_path).to eq("C:\\PROGRA~1")
  end

  it 'returns the same string if already short' do
    expect(Pathname2.new("C:/").short_path).to eq("C:\\")
  end

  it 'fails if the path does not exist' do
    expect { Pathname2.new("C:/Bogus/AlsoBogus").short_path }.to raise_error(Errno::ESRCH)
  end

  it 'is not destructive' do
    str = 'C:/Program Files'
    Pathname2.new(str).short_path
    expect(str).to eq('C:/Program Files')
  end
end
