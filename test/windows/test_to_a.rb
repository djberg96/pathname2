########################################################################
# test_to_a.rb
#
# Test suite for the Pathname#to_a method.
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname_ToA < Test::Unit::TestCase
  def setup
    @path = Pathname.new('C:/Program Files/foo')
  end

  test 'to_a basic functionality' do
    assert_respond_to(@path, :to_a)
    assert_nothing_raised{ @path.to_a }
    assert_kind_of(Array, @path.to_a)
  end

  test 'to_a returns the expected results for standard paths' do
    assert_equal(['C:'], Pathname.new('C:/').to_a)
    assert_equal(['C:', 'Program Files'], Pathname.new('C:/Program Files').to_a)
    assert_equal(['C:', 'Program Files', 'Stuff'], Pathname.new('C:/Program Files/Stuff').to_a)
    assert_equal(['C:', 'Users'], Pathname.new('C:\\Users').to_a)
  end

  test 'to_a returns the expected results for unc paths' do
    assert_equal(['foo', 'bar', 'baz'], Pathname.new('//foo/bar/baz').to_a)
    assert_equal(['foo', 'bar'], Pathname.new('//foo/bar').to_a)
    assert_equal(['foo'], Pathname.new('//foo').to_a)
  end

  test 'to_a returns the expected results for empty strings and empty unc paths' do
    assert_equal([], Pathname.new('').to_a)
    assert_equal([], Pathname.new('//').to_a)
  end

  test 'to_a does not modify receiver' do
    @path.to_a
    assert_equal('C:\Program Files\foo', @path)
  end

  def teardown
    @path = nil
  end
end
