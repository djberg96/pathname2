require 'spec_helper'

RSpec.describe Pathname2, '#clean' do
  let(:path) { Pathname2.new("C:\\foo\\..\\bar\\.\\baz") }

  it 'has clean method' do
    expect(path).to respond_to(:clean)
  end

  it 'returns a Pathname2 object' do
    expect(path.clean).to be_a(Pathname2)
  end

  it 'cleans unclean paths' do
    expect(Pathname2.new("C:\\a\\.\\b\\..\\c").clean).to eq("C:\\a\\c")
    expect(Pathname2.new("C:\\.\\a").clean).to eq("C:\\a")
    expect(Pathname2.new("C:\\a\\.\\b").clean).to eq("C:\\a\\b")
    expect(Pathname2.new("C:\\a\\..\\b").clean).to eq("C:\\b")
    expect(Pathname2.new("C:\\a\\.").clean).to eq("C:\\a")
    expect(Pathname2.new("C:\\..\\..\\..\\d").clean).to eq("C:\\d")
  end

  it 'returns already clean paths unmodified' do
    expect(Pathname2.new("C:\\").clean).to eq("C:\\")
    expect(Pathname2.new("C:\\a").clean).to eq("C:\\a")
    expect(Pathname2.new("C:\\a\\").clean).to eq("C:\\a\\")
    expect(Pathname2.new("\\\\foo\\bar").clean).to eq("\\\\foo\\bar")
    expect(Pathname2.new("a").clean).to eq("a")
  end

  it 'returns a slash for . and ..' do
    expect(Pathname2.new(".").clean).to eq("\\")
    expect(Pathname2.new("..").clean).to eq("\\")
  end

  it 'does not modify receiver' do
    path.clean
    expect(path).to eq("C:\\foo\\..\\bar\\.\\baz")
  end
end
