########################################################################
# test_is_absolute.rb
#
# Test suite for the Pathname2#absolute method
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname2_IsAbsolute < Test::Unit::TestCase
  def setup
    @abs_std = Pathname2.new("C:/foo/bar/baz")
    @abs_unc = Pathname2.new("//foo/bar/baz")
  end

  test "absolute? basic functionality" do
    assert_respond_to(@abs_std, :absolute?)
    assert_nothing_raised{ @abs_std.absolute? }
    assert_boolean(@abs_std.absolute?)
  end

  test "absolute? method returns true for absolute paths" do
    assert_true(@abs_std.absolute?)
    assert_true(@abs_unc.absolute?)
  end

  test "absolute? method returns false for non-absolute paths" do
    assert_false(Pathname2.new("foo").absolute?)
    assert_false(Pathname2.new("foo/bar").absolute?)
  end

  test "absolute? method returns false for empty path" do
    assert_false(Pathname2.new("").absolute?)
  end

  test "absolute? method is not destructive" do
    str = 'C:/foo'
    path = Pathname2.new(str)
    assert_nothing_raised{ path.absolute? }
    assert_equal('C:\foo', path.to_s)
    assert_equal('C:/foo', str)
  end

  def teardown
    @std_absolute = nil
    @unc_absolute = nil
  end
end
