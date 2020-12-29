########################################################################
# test_realpath.rb
#
# Test suite for the Pathname#realpath method
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname_Realpath < Test::Unit::TestCase
  def setup
    @cwd  = Dir.pwd.tr('/', "\\")
    @path = Pathname.new(Dir.pwd)
  end

  test "realpath basic functionality" do
    assert_respond_to(@path, :realpath)
    assert_nothing_raised{ @path.realpath }
    assert_kind_of(String, @path.realpath)
  end

  test "realpath returns the expected result" do
    assert_equal(@cwd, @path.realpath)
  end

  test "realpath fails if the path does not exist" do
    assert_raise(Errno::ENOENT){ Pathname.new("C:/Bogus/AlsoBogus").realpath }
  end

  test "realpath method is not destructive" do
    str = 'C:/Program Files'
    assert_nothing_raised{ Pathname.new(str).realpath }
    assert_equal('C:/Program Files', str)
  end

  def teardown
    @cwd  = nil
    @path = nil
  end
end
