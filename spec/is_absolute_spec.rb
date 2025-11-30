########################################################################
# is_absolute_spec.rb
#
# Test suite for the Pathname2#absolute method.
########################################################################
require 'rspec'
require 'pathname2'

RSpec.describe Pathname2, :unix => true, :absolute => true do
  let(:abs_path){ described_class.new('/usr/local/bin') }
  let(:rel_path){ described_class.new('usr/local/bin') }

  example "absolute? basic functionality" do
    expect(abs_path).to respond_to(:absolute?)
    expect{ abs_path.absolute? }.not_to raise_error
  end

  example "absolute? returns a boolean value" do
    expect(abs_path.absolute?).to be(true).or be(false)
  end

  example "absolute? method returns true for absolute paths" do
    expect(abs_path.absolute?).to be true
  end

  example "absolute? method returns false for relative paths" do
    expect(rel_path.absolute?).to be false
    expect(described_class.new("foo").absolute?).to be false
    expect(described_class.new("foo/bar").absolute?).to be false
  end

  example "absolute? method returns false for empty path" do
    expect(described_class.new("").absolute?).to be false
  end

  example "absolute? method is not destructive" do
    str = '/usr/local/bin'
    path = described_class.new(str)
    expect{ path.absolute? }.not_to raise_error
    expect(path.to_s).to eq(str)
    expect(str).to eq('/usr/local/bin')
  end
end
