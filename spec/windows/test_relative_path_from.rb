########################################################################
# test_relative_path_from.rb
#
# Test suite for the Pathname#relative_path_from method.
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname_RelativePathFrom < Test::Unit::TestCase
  def assert_relpath(result, dest, base)
    assert_equal(result, Pathname.new(dest).relative_path_from(base))
  end

  def assert_relative_path_error(to, from)
    assert_raise(ArgumentError){ Pathname.new(to).relative_path_from(from) }
  end

  test "relative_path_from works as expected between two relative paths" do
    assert_relpath("..\\a", 'a', 'b')
    assert_relpath("..\\a", 'a', 'b/')
    assert_relpath("..\\a", 'a/', 'b')
    assert_relpath("..\\a", 'a/', 'b/')
    assert_relpath("..\\b", "a\\b", "a\\c")
    assert_relpath("..\\a", "..\\a", "..\\b")
    assert_relpath("..\\b\\c", "a\\b\\c", "a\\d")
    assert_relpath("..", "a\\..", "a")
    assert_relpath(".", "a\\..\\b", "b")
    assert_relpath("a", "a", "b\\..")
    assert_relpath("b\\c", "b\\c", "b\\..")
  end

  test "relative_path_from works as expected between two absolute paths" do
    assert_relpath("..\\a", "c:\\a", "c:\\b")
    assert_relpath("..\\a", "c:\\a", "c:\\b\\")
    assert_relpath("..\\a", "c:\\a\\", "c:\\b")
    assert_relpath("..\\a", "c:\\a\\", "c:\\b\\")
    assert_relpath("c\\d", "c:\\a\\b\\c\\d", "c:\\a\\b")
    assert_relpath("..\\..", "c:\\a\\b", "c:\\a\\b\\c\\d")
    assert_relpath("..\\..\\..\\..\\e", "c:\\e", "c:\\a\\b\\c\\d")
    assert_relpath("..\\a", "c:\\..\\a", "c:\\b")
    assert_relpath(".", "c:\\a\\..\\..\\b", "c:\\b")
  end

  test "relative_path_from works as expected between for . and .." do
    assert_relpath("a", "a", ".")
    assert_relpath("..", ".", "a")
    assert_relpath(".", ".", ".")
    assert_relpath(".", "..", "..")
    assert_relpath("..", "..", ".")
  end

  test "relative_path_from is not allowed between relative and absolute paths" do
    assert_relative_path_error("c:\\", ".")
    assert_relative_path_error(".", "c:\\")
    assert_relative_path_error("a", "..")
    assert_relative_path_error(".", "..")
    assert_relative_path_error("C:\\Temp", "D:\\Temp")
    assert_relative_path_error("\\\\Server\\Temp", "D:\\Temp")
  end
end
