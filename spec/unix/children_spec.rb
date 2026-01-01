require 'spec_helper'

RSpec.describe Pathname2, '#children' do
  before do
    @original_dir = Dir.pwd
    Dir.chdir(File.expand_path(File.dirname(__FILE__)))
  end

  after do
    Dir.chdir(@original_dir)
  end

  let(:cur_path) { Pathname2.new(Dir.pwd) }

  it 'has children method' do
    expect(cur_path).to respond_to(:children)
  end

  it 'returns array of children' do
    expect(cur_path.children).to be_a(Array)
  end

  context 'with directory included' do
    it 'returns children with full paths' do
      cur_dir = Dir.pwd
      children = cur_path.children.sort.reject { |f| f.include?('git') || f.include?('.swp') }
      # The actual paths will vary, but ensure they're absolute
      children.each do |child|
        expect(child).to be_a(String)
        # Check that the child path contains the current directory
        expect(child).to include(cur_dir)
      end
    end
  end

  context 'without directory' do
    it 'returns children with relative paths' do
      children = cur_path.children(false).reject { |f| f.include?('git') || f.include?('.swp') }
      children.each do |child|
        expect(child).to be_a(String)
        expect(child).not_to include('/')
      end
    end
  end
end
