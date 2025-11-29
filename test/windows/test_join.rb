########################################################################
# test_join.rb
#
# Test suite for the Pathname2#join method.
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname2_Join < Test::Unit::TestCase
  def setup
    @apath = Pathname2.new("C:\\foo\\bar")
    @rpath = Pathname2.new("foo\\bar\\baz")
  end

  def assert_pathname_join(final, initial, *rest)
    a = Pathname2.new(final)
    b = Pathname2.new(initial)
    assert_equal(a, b.join(*rest))
  end

  test "join method accepts one or more arguments" do
    assert_nothing_raised{ @apath.join("foo") }
    assert_nothing_raised{ @apath.join("foo", "bar") }
    assert_nothing_raised{ @apath.join("foo", "bar", "baz") }
  end

  test "join method returns expected results when joining relative paths to an absolute path" do
    assert_pathname_join("C:\\foo", "C:\\", "foo")
    assert_pathname_join("C:\\foo\\bar", "C:\\foo", "bar")
    assert_pathname_join("C:\\foo\\bar\\baz", "C:\\foo", "bar", "baz")
  end

  test "join method returns expected results when joining relative paths to a relative path" do
    assert_pathname_join("foo\\bar", "foo", "bar")
    assert_pathname_join("foo\\bar\\baz", "foo", "bar", "baz")
  end

  test "join method returns expected results when joining an absolute path to an absolute path" do
    assert_pathname_join("D:\\", "C:\\", "D:\\")
    assert_pathname_join("D:\\foo", "C:\\", "D:\\", "foo")
    assert_pathname_join("D:\\", "C:\\", "foo", "bar", "D:\\")
  end

  test "join returns an instance of Pathname2" do
    assert_kind_of(Pathname2, @apath.join("foo"))
  end

  def teardown
    @apath = nil
    @rpath = nil
  end
end
