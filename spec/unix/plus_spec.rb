require 'spec_helper'

RSpec.describe Pathname2, '#+' do
  def assert_pathname_plus(a, b, c)
    a = Pathname2.new(a)
    b = Pathname2.new(b)
    c = Pathname2.new(c)
    expect(b + c).to eq(a)
  end

  it 'has + operator' do
    expect(Pathname2.new('/usr/local/bin')).to respond_to(:+)
  end

  it 'appends relative paths correctly' do
    assert_pathname_plus('/foo/bar', '/foo', 'bar')
    assert_pathname_plus('foo/bar', 'foo', 'bar')
  end

  it 'handles current directory correctly' do
    assert_pathname_plus('foo', 'foo', '.')
    assert_pathname_plus('foo', '.', 'foo')
  end

  it 'handles absolute path as second argument' do
    assert_pathname_plus('/foo', 'bar', '/foo')
  end

  it 'handles parent directory references' do
    assert_pathname_plus('foo', 'foo/bar', '..')
    assert_pathname_plus('/foo', '/', '../foo')
    assert_pathname_plus('foo/zap', 'foo/bar', '../zap')
    assert_pathname_plus('.', 'foo', '..')
  end

  it 'auto-cleans paths' do
    assert_pathname_plus('foo', '..', 'foo')
    assert_pathname_plus('foo', '..', '../foo')
  end

  it 'handles edge cases' do
    assert_pathname_plus('.', '.', '.')
    assert_pathname_plus('/', '/', '..')
    assert_pathname_plus('.', '..', '..')
    assert_pathname_plus('.', 'foo', '..')
  end

  it 'has / as alias for +' do
    result = Pathname2.new('/foo') / Pathname2.new('bar')
    expect(result).to eq('/foo/bar')
  end
end
