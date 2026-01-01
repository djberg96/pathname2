require 'spec_helper'

RSpec.describe Pathname2, '#pstrip' do
  let(:path) { Pathname2.new("C:/Program Files////") }

  it 'has pstrip method' do
    expect(path).to respond_to(:pstrip)
  end

  it 'returns a Pathname2 object' do
    expect(path.pstrip).to be_a(Pathname2)
  end

  it 'returns expected result for path with trailing slashes' do
    expect(path.pstrip).to eq("C:\\Program Files")
    expect(Pathname2.new("C:\\Program Files\\\\").pstrip).to eq("C:\\Program Files")
    expect(Pathname2.new("C:\\Program Files//\\").pstrip).to eq("C:\\Program Files")
  end

  it 'returns the path as is if no trailing slash' do
    expect(Pathname2.new("C:\\Program Files").pstrip).to eq("C:\\Program Files")
    expect(Pathname2.new("").pstrip).to eq("")
  end

  it 'is not destructive' do
    str = 'C:/Program Files////'
    Pathname2.new(str).pstrip
    expect(str).to eq('C:/Program Files////')
  end
end
