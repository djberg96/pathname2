require 'spec_helper'

RSpec.describe Pathname2, '#children' do
  let(:dir) { 'foo' }
  let(:path) { Pathname2.new(File.dirname(File.dirname(__FILE__))) }

  before do
    Dir.mkdir(dir)
    Dir.chdir(dir) do
      FileUtils.touch('alpha')
      FileUtils.touch('beta')
      FileUtils.touch('gamma')
    end
  end

  after do
    FileUtils.rm_rf(dir) if File.exist?(dir)
  end

  it 'has children method' do
    expect(path).to respond_to(:children)
  end

  it 'returns an array' do
    expect(path.children).to be_a(Array)
  end

  it 'returns expected results' do
    test_path = Pathname2.new(dir)
    expect(test_path.children).to eq(%w[foo\alpha foo\beta foo\gamma])
  end

  it 'returns Pathname2 objects' do
    test_path = Pathname2.new(dir)
    expect(test_path.children.first).to be_a(Pathname2)
  end
end
