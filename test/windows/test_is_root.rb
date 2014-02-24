########################################################################
# test_is_root.rb
#
# Test suite for the Pathname#root method
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname_IsRoot < Test::Unit::TestCase
  def setup
    @std_root = Pathname.new("C:\\")
    @unc_root = Pathname.new("\\\\foo\\bar")
  end

  test "root? basic functionality" do
    assert_respond_to(@std_root, :root?)
    assert_nothing_raised{ @std_root.root? }
    assert_boolean(@std_root.root?)
  end

  test "root? method returns true for root paths" do
    assert_true(@std_root.root?)
    assert_true(@unc_root.root?)
  end

  test "root? method returns false for non-root paths" do
    assert_false(Pathname.new("C:/foo").root?)
    assert_false(Pathname.new("//foo/bar/baz").root?)
    assert_false(Pathname.new("").root?)
  end

  test "root? method is not destructive" do
    str = 'C:/foo'
    path = Pathname.new(str)
    assert_nothing_raised{ path.root }
    assert_equal('C:/foo', path.to_s)
    assert_equal('C:/foo', str)
  end

  def teardown
    @std_root = nil
    @unc_root = nil
  end
end
