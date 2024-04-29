########################################################################
# test_ascend.rb
#
# Test suite for the Pathname#ascend method.
########################################################################
require 'pathname2'
require 'test-unit'

class TC_Pathname_Ascend < Test::Unit::TestCase
  def setup
    @path = Pathname.new('C:\\foo\\bar\\baz')
  end

  test 'ascend basic functionality' do
    assert_respond_to(@path, :ascend)
    assert_nothing_raised{ @path.ascend{} }
  end

  test 'ascend works as expected on a standard absolute path' do
    array = []
    @path.ascend{ |e| array << e }
    assert_equal('C:\foo\bar\baz', array[0])
    assert_equal('C:\foo\bar', array[1])
    assert_equal('C:\foo', array[2])
    assert_equal('C:', array[3])
  end

  test 'ascend works as expected on a UNC path' do
    array = []
    Pathname.new('//foo/bar/baz').ascend{ |e| array << e }
    assert_equal('\\\\foo\\bar\\baz', array[0])
    assert_equal('\\\\foo\\bar', array[1])
  end

  test 'ascend works as expected on a relative path' do
    array = []
    Pathname.new('foo/bar/baz').ascend{ |e| array << e }
    assert_equal('foo\bar\baz', array[0])
    assert_equal('foo\bar', array[1])
    assert_equal('foo', array[2])
  end

  test 'ascend does not modify the receiver' do
    @path.ascend{}
    assert_equal('C:\foo\bar\baz', @path)
  end

  def teardown
    @path = nil
  end
end
