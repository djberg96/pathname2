########################################################################
# test_append.rb
#
# Test suite for the Pathname#append method.
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname_Append < Test::Unit::TestCase
  def setup
    @abs_path = Pathname.new("C:\\foo\\bar")
    @rel_path = Pathname.new("foo\\bar\\baz")
  end

  def assert_pathname_plus(a, b, c)
    a = Pathname.new(a)
    b = Pathname.new(b)
    c = Pathname.new(c)
    assert_equal(a, b + c)
  end

  test "appending a string to an absolute path works as expected" do
    assert_pathname_plus("C:\\a\\b", "C:\\a", "b")
    assert_pathname_plus("C:\\b", "a", "C:\\b")
    assert_pathname_plus("a\\b", "a", "b")
    assert_pathname_plus("C:\\b", "C:\\a", "..\\b")
    assert_pathname_plus("C:\\a\\b", "C:\\a\\.", "\\b")
    assert_pathname_plus("C:\\a\\b.txt", "C:\\a", "b.txt")
  end

  test "appending a string to a UNC path works as expected" do
    assert_pathname_plus("\\\\foo\\bar", "\\\\foo", "bar")
    assert_pathname_plus("\\\\foo", "\\\\", "foo")
    assert_pathname_plus("\\\\", "\\\\", "")
    assert_pathname_plus("\\\\foo\\baz", "\\\\foo\\bar", "\\..\\baz")
    assert_pathname_plus("\\\\", "\\\\", "..\\..\\..\\..")
  end

  test "appending a plain string to a path works as expected" do
    assert_nothing_raised{ @abs_path + "bar" }
    assert_equal('C:\foo\bar\baz', @abs_path + 'baz')
    assert_equal('C:\foo\bar', @abs_path)
  end

  test "appending an absolute path results in that absolute path" do
    assert_pathname_plus('C:\foo\bar', @rel_path, @abs_path)
  end

  test "neither receiver nor argument are modified" do
    assert_nothing_raised{ @abs_path + @rel_path }
    assert_equal('C:\foo\bar\foo\bar\baz', @abs_path + @rel_path)
    assert_equal('C:\foo\bar', @abs_path)
    assert_equal('foo\bar\baz', @rel_path)
  end

  def teardown
    @path = nil
  end
end
