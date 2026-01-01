require 'spec_helper'

RSpec.describe Pathname2, '#join' do
  let(:apath) { Pathname2.new("C:\\foo\\bar") }
  let(:rpath) { Pathname2.new("foo\\bar\\baz") }

  def assert_pathname_join(final, initial, *rest)
    a = Pathname2.new(final)
    b = Pathname2.new(initial)
    expect(b.join(*rest)).to eq(a)
  end

  it 'accepts one or more arguments' do
    expect { apath.join("foo") }.not_to raise_error
    expect { apath.join("foo", "bar") }.not_to raise_error
    expect { apath.join("foo", "bar", "baz") }.not_to raise_error
  end

  it 'joins relative paths to an absolute path' do
    assert_pathname_join("C:\\foo", "C:\\", "foo")
    assert_pathname_join("C:\\foo\\bar", "C:\\foo", "bar")
    assert_pathname_join("C:\\foo\\bar\\baz", "C:\\foo", "bar", "baz")
  end

  it 'joins relative paths to a relative path' do
    assert_pathname_join("foo\\bar", "foo", "bar")
    assert_pathname_join("foo\\bar\\baz", "foo", "bar", "baz")
  end

  it 'joins an absolute path to an absolute path' do
    assert_pathname_join("D:\\", "C:\\", "D:\\")
    assert_pathname_join("D:\\foo", "C:\\", "D:\\", "foo")
    assert_pathname_join("D:\\", "C:\\", "foo", "bar", "D:\\")
  end

  it 'returns an instance of Pathname2' do
    expect(apath.join("foo")).to be_a(Pathname2)
  end
end
