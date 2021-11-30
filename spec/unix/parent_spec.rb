########################################################################
# parent_spec.rb
#
# Test suite for the Pathname#parent method.
########################################################################
require 'rspec'
require 'pathname2'

RSpec.describe Pathname, :unix => true, :parent => true do
  let(:abs_path){ Pathname.new('/usr/local/bin') }
  let(:rel_path){ Pathname.new('usr/local/bin') }
  let(:root_path){ Pathname.new('/') }

  example "parent basic functionality" do
    expect(abs_path).to respond_to(:parent)
    expect{ abs_path.parent }.not_to raise_error
  end

  example "parent returns the expected value for an absolute path" do
    expect(abs_path.parent).to eq('/usr/local')
  end

  example "parent returns the expected value for a relative path" do
    expect(rel_path.parent).to eq('usr/local')
  end

  example "parent returns the expected value for a root path" do
    expect(root_path.parent).to eq('/')
  end

  example "parent does not accept any arguments" do
    expect{ abs_path.parent(1) }.to raise_error(ArgumentError)
  end
end
