########################################################################
# append_spec.rb
#
# Specs for the Pathname#append method.
########################################################################
require 'spec_helper'
require 'pathname2'

RSpec.describe Pathname, :unix => true, :append => true do
  let(:abs_path){ Pathname.new('/usr/local/bin') }
  let(:rel_path){ Pathname.new('usr/local/bin') }

  example "pathname_append basic functionality" do
    expect(abs_path).to respond_to(:+)
  end

  example "appending a relative path to an absolute path works as expected" do
    expect(described_class.new("/foo") + "bar").to eq("/foo/bar")
  end

  example "appending an absolute path to a relative path returns that absolute path" do
    expect(described_class.new("foo") + "/bar").to eq("/bar")
  end

  example "appending an absolute path to an absolute path returns that absolute path" do
    expect(described_class.new("/foo") + "/bar").to eq("/bar")
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

  example "appending '.' and '..' works as expected" do
    expect(described_class.new('.') + '.').to eq('.')
    expect(described_class.new('/') + '..').to eq('/')
    expect(described_class.new('..') + '..').to eq('.')
    expect(described_class.new('foo') + '..').to eq('.')
  end

  example "the '/' method is an alias for '+'" do
    expect(described_class.instance_method(:+)).to eq(described_class.instance_method(:/))
  end

  example "neither the receiver nor the argument to the constructor are modified" do
    expect{ abs_path + rel_path }.not_to raise_error
    expect(abs_path).to eq('/usr/local/bin')
    expect(rel_path).to eq('usr/local/bin')
  end
end
