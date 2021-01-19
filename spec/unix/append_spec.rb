########################################################################
# append_spec.rb
#
# Specs for the Pathname#append method.
########################################################################
require 'spec_helper'
require 'pathname2'

RSpec.describe Pathname, :unix => true, :append => true do
  before do
    @abs_path = Pathname.new('/usr/local/bin')
    @rel_path = Pathname.new('usr/local/bin')
  end

  example "pathname_append basic functionality" do
    expect(@abs_path).to respond_to(:+)
  end

  example "appending a relative path to an absolute path works as expected" do
    expect(described_class.new("/foo") + "bar").to eq("/foo/bar")
  end

  example "appending an absolute path to a relative path works as expected" do
    expect(described_class.new("foo") + "/bar").to eq("/bar")
  end

  example "appending a relative path to a relative path works as expected" do
    expect(described_class.new("foo") + "bar").to eq("foo/bar")
  end

  example "appending a '.' to a path works as expected" do
    expect(described_class.new("foo") + ".").to eq("foo")
    expect(described_class.new("/foo") + ".").to eq("/foo")
  end

  example "appending a path with a '.' works as expected" do
    expect(described_class.new(".") + "foo").to eq("foo")
    expect(described_class.new(".") + "/foo").to eq("/foo")
  end

  example "appending a '..' to a path works as expected" do
    expect(described_class.new("foo/bar") + "..").to eq("foo")
    expect(described_class.new("foo/bar") + "../zap").to eq("foo/zap")
    expect(described_class.new("/") + "../foo").to eq("/foo")
    expect(described_class.new("foo") + "..").to eq(".")
  end

  example "appending a path with a '..' works as expected" do
    expect(described_class.new("..") + "foo").to eq("foo")
    expect(described_class.new("..") + "../foo").to eq("foo")
  end

=begin
    # Edge cases
    assert_pathname_plus('.', '.', '.')
    assert_pathname_plus('/', '/', '..')
    assert_pathname_plus('.', '..',  '..')
    assert_pathname_plus('.', 'foo', '..')

    # Alias
    assert_equal('/foo/bar', Pathname.new('/foo') / Pathname.new('bar'))
  end


  example "appending a string to a UNC path works as expected" do
    expect_pathname_plus("\\\\foo\\bar", "\\\\foo", "bar")
    expect_pathname_plus("\\\\foo", "\\\\", "foo")
    expect_pathname_plus("\\\\", "\\\\", "")
    expect_pathname_plus("\\\\foo\\baz", "\\\\foo\\bar", "\\..\\baz")
    expect_pathname_plus("\\\\", "\\\\", "..\\..\\..\\..")
  end

  example "appending a plain string to a path works as expected" do
    expect{ @abs_path + "bar" }.not_to raise_error
    expect( @abs_path + 'baz').to eq('C:\foo\bar\baz')
    expect( @abs_path).to eq('C:\foo\bar')
  end

  example "appending an absolute path results in that absolute path" do
    expect_pathname_plus('C:\foo\bar', @rel_path, @abs_path)
  end

  example "neither receiver nor argument are modified" do
    expect{ @abs_path + @rel_path }.not_to raise_error
    expect( @abs_path + @rel_path).to eq('C:\foo\bar\foo\bar\baz')
    expect( @abs_path).to eq('C:\foo\bar')
    expect( @rel_path).to eq('foo\bar\baz')
  end
=end
end
