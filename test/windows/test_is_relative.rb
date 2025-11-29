########################################################################
# test_is_relative.rb
#
# Test suite for the Pathname2#relative method
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname2_IsRelative < Test::Unit::TestCase
  def setup
    @relative = Pathname2.new("foo/bar")
    @absolute = Pathname2.new("C:/foo/bar")
  end

  test "relative? basic functionality" do
    assert_respond_to(@relative, :relative?)
    assert_nothing_raised{ @relative.relative? }
    assert_boolean(@relative.relative?)
  end

  test "relative? method returns true for relative paths" do
    assert_true(@relative.relative?)
  end

  test "relative? method returns false for non-relative paths" do
    assert_false(@absolute.relative?)
    assert_false(Pathname2.new("//foo/bar").relative?)
  end

  test "relative? method returns true for empty path" do
    assert_true(Pathname2.new("").relative?)
  end

  test "relative? method is not destructive" do
    str = 'C:/foo'
    path = Pathname2.new(str)
    assert_nothing_raised{ path.relative? }
    assert_equal('C:\foo', path.to_s)
    assert_equal('C:/foo', str)
  end

  def teardown
    @std_relative = nil
    @unc_relative = nil
  end
end
