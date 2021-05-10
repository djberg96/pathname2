########################################################################
# is_absolute_spec.rb
#
# Test suite for the Pathname#absolute method.
########################################################################
require 'rspec'
require 'pathname2'

RSpec.describe Pathname, :unix => true, :absolute => true do
  let(:abs_path){ Pathname.new('/usr/local/bin') }
  let(:rel_path){ Pathname.new('usr/local/bin') }

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
    expect(Pathname.new("foo").absolute?).to be false
    expect(Pathname.new("foo/bar").absolute?).to be false
  end

  example "absolute? method returns false for empty path" do
    expect(Pathname.new("").absolute?).to be false
  end

  example "absolute? method is not destructive" do
    str = '/usr/local/bin'
    path = Pathname.new(str)
    expect{ path.absolute? }.not_to raise_error
    expect(path.to_s).to eq(str)
    expect(str).to eq('/usr/local/bin')
  end
end
