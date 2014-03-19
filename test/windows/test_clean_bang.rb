########################################################################
# test_clean_bang.rb
#
# Test suite for the Pathname#clean! method.
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname_CleanBang < Test::Unit::TestCase
  def setup
    @path = Pathname.new("C:\\foo\\..\\bar\\.\\baz")
  end

  test "clean basic functionality" do
    assert_respond_to(@path, :clean!)
    assert_nothing_raised{ @path.clean! }
    assert_kind_of(Pathname, @path.clean!)
  end

  test "clean returns expected results for unclean paths" do
    assert_equal("C:\\a\\c", Pathname.new("C:\\a\\.\\b\\..\\c").clean!)
    assert_equal("C:\\a", Pathname.new("C:\\.\\a").clean!)
    assert_equal("C:\\a\\b", Pathname.new("C:\\a\\.\\b").clean!)
    assert_equal("C:\\b", Pathname.new("C:\\a\\..\\b").clean!)
    assert_equal("C:\\a", Pathname.new("C:\\a\\.").clean!)
    assert_equal("C:\\d", Pathname.new("C:\\..\\..\\..\\d").clean!)
  end

  test "clean returns already clean paths unmodified" do
    assert_equal("C:\\", Pathname.new("C:\\").clean!)
    assert_equal("C:\\a", Pathname.new("C:\\a").clean!)
    assert_equal("C:\\a\\", Pathname.new("C:\\a\\").clean!)
    assert_equal("\\\\foo\\bar", Pathname.new("\\\\foo\\bar").clean!)
    assert_equal("a", Pathname.new("a").clean!)
  end

  test "clean returns a slash for . and .." do
    assert_equal("\\", Pathname.new(".").clean!)
    assert_equal("\\", Pathname.new("..").clean!)
  end

  test "clean! modifies receiver" do
    @path.clean!
    assert_equal("C:\\bar\\baz", @path)
  end

  def teardown
    @path = nil
  end
end
