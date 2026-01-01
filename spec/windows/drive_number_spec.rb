require 'spec_helper'

RSpec.describe Pathname2, '#drive_number' do
  let(:abs_path) { Pathname2.new("C:\\Program Files") }
  let(:unc_path) { Pathname2.new("\\\\foo\\bar\\baz") }
  let(:rel_path) { Pathname2.new("foo\\bar\\baz") }

  it 'returns expected results for absolute paths' do
    expect(abs_path.drive_number).to eq(2)
  end

  it 'returns expected results for paths with forward slashes' do
    expect(Pathname2.new("C:/Program Files").drive_number).to eq(2)
  end

  it 'returns nil for UNC paths' do
    expect(unc_path.drive_number).to be_nil
    expect(Pathname2.new("\\\\foo").drive_number).to be_nil
    expect(Pathname2.new("\\\\").drive_number).to be_nil
  end

  it 'returns nil for relative paths' do
    expect(rel_path.drive_number).to be_nil
  end

  it 'returns expected result for root path' do
    expect(Pathname2.new("Z:\\").drive_number).to eq(25)
  end

  it 'returns nil for empty string' do
    expect(Pathname2.new("").drive_number).to be_nil
  end

  it 'returns nil for dot and dotdot' do
    expect(Pathname2.new(".").drive_number).to be_nil
    expect(Pathname2.new("..").drive_number).to be_nil
  end

  it 'is not destructive' do
    str = 'C:/Program Files'
    Pathname2.new(str).drive_number
    expect(str).to eq('C:/Program Files')
  end
end
