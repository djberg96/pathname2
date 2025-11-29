########################################################################
# test_descend.rb
#
# Test suite for the Pathname2#descend method.
########################################################################
require 'pathname2'
require 'test-unit'

class TC_Pathname2_Descend < Test::Unit::TestCase
  def setup
    @path = Pathname2.new("C:\\foo\\bar\\baz")
  end

  test "descend basic functionality" do
    assert_respond_to(@path, :descend)
    assert_nothing_raised{ @path.descend{} }
  end

  test "descend works as expected on a standard absolute path" do
    array = []
    @path.descend{ |e| array << e }
    assert_equal('C:', array[0])
    assert_equal('C:\foo', array[1])
    assert_equal('C:\foo\bar', array[2])
    assert_equal('C:\foo\bar\baz', array[3])
  end

  test "descend works as expected on a UNC path" do
    array = []
    Pathname2.new('//foo/bar/baz').descend{ |e| array << e }
    assert_equal("\\\\foo\\bar", array[0])
    assert_equal("\\\\foo\\bar\\baz", array[1])
  end

  test "descend works as expected on a relative path" do
    array = []
    Pathname2.new('foo/bar/baz').descend{ |e| array << e }
    assert_equal('foo', array[0])
    assert_equal('foo\bar', array[1])
    assert_equal('foo\bar\baz', array[2])
  end

  test "descend does not modify the receiver" do
    @path.descend{}
    assert_equal('C:\foo\bar\baz', @path)
  end

  def teardown
    @path = nil
  end
end
