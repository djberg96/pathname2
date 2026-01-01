require 'spec_helper'

RSpec.describe Pathname2, '#children' do
  let(:cur_path) { Pathname2.new(Dir.pwd) }

  before do
    Dir.chdir(File.expand_path(File.dirname(__FILE__)))
  end

  it 'has children method' do
    expect(cur_path).to respond_to(:children)
  end

  it 'returns array of children' do
    expect(cur_path.children).to be_a(Array)
  end

  context 'with directory included' do
    it 'returns children with full paths' do
      children = cur_path.children.sort.reject { |f| f.include?('git') || f.include?('.swp') }
      # The actual paths will vary, but ensure they're absolute
      children.each do |child|
        expect(child).to be_a(String)
        expect(child).to start_with(Dir.pwd)
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
