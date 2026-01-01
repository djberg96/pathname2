require 'spec_helper'

RSpec.describe Pathname2, '#relative_path_from' do
  def assert_relpath(result, dest, base)
    expect(Pathname2.new(dest).relative_path_from(base)).to eq(result)
  end

  def assert_relpath_err(to, from)
    expect { Pathname2.new(to).relative_path_from(from) }.to raise_error(ArgumentError)
  end

  it 'handles basic relative paths' do
    assert_relpath('../a', 'a', 'b')
    assert_relpath('../a', 'a', 'b/')
    assert_relpath('../a', 'a/', 'b')
    assert_relpath('../a', 'a/', 'b/')
  end

  it 'handles absolute paths' do
    assert_relpath('../a', '/a', '/b')
    assert_relpath('../a', '/a', '/b/')
    assert_relpath('../a', '/a/', '/b')
    assert_relpath('../a', '/a/', '/b/')
  end

  it 'handles nested paths' do
    assert_relpath('../b', 'a/b', 'a/c')
    assert_relpath('../a', '../a', '../b')
  end

  it 'handles current and parent directories' do
    assert_relpath('a', 'a', '.')
    assert_relpath('..', '.', 'a')
    assert_relpath('.', '.', '.')
    assert_relpath('.', '..', '..')
    assert_relpath('..', '..', '.')
  end

  it 'handles complex nested paths' do
    assert_relpath('c/d', '/a/b/c/d', '/a/b')
    assert_relpath('../..', '/a/b', '/a/b/c/d')
    assert_relpath('../../../../e', '/e', '/a/b/c/d')
    assert_relpath('../b/c', 'a/b/c', 'a/d')
  end

  it 'handles paths with parent references' do
    assert_relpath('../a', '/../a', '/b')
    assert_relpath('.', '/a/../../b', '/b')
    assert_relpath('..', 'a/..', 'a')
    assert_relpath('.', 'a/../b', 'b')
  end

  it 'handles parent directory cleanup' do
    assert_relpath('a', 'a', 'b/..')
    assert_relpath('b/c', 'b/c', 'b/..')
  end

  it 'raises error for mixed absolute and relative paths' do
    assert_relpath_err('/', '.')
    assert_relpath_err('.', '/')
    assert_relpath_err('a', '..')
    assert_relpath_err('.', '..')
  end
end
