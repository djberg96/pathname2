require 'spec_helper'

RSpec.describe Pathname2, '#<=>' do
  def assert_pathname_cmp(int, s1, s2)
    p1 = Pathname2.new(s1)
    p2 = Pathname2.new(s2)
    result = p1 <=> p2
    expect(result).to eq(int)
  end

  it 'has <=> operator' do
    expect(Pathname2.new('/usr/local/bin')).to respond_to(:<=>)
  end

  it 'returns 0 for equal paths' do
    assert_pathname_cmp(0, '/foo/bar', '/foo/bar')
  end

  it 'returns -1 when first path is less than second' do
    assert_pathname_cmp(-1, '/foo/bar', '/foo/zap')
    assert_pathname_cmp(-1, 'foo', 'foo/')
    assert_pathname_cmp(-1, 'foo/', 'foo/bar')
  end

  it 'returns 1 when first path is greater than second' do
    assert_pathname_cmp(1, '/foo/zap', '/foo/bar')
  end
end
