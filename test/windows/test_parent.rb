########################################################################
# test_parent.rb
#
# Test suite for the Pathname2#parent method.
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname2_Parent < Test::Unit::TestCase
  def setup
    @path = Pathname2.new("C:\\foo\\bar\\baz")
  end

  test "parent basic functionality" do
    assert_respond_to(@path, :parent)
    assert_nothing_raised{ @path.parent }
    assert_kind_of(Pathname2, @path.parent)
  end

  test "parent returns expected results for an absolute path" do
    assert_equal("C:\\foo\\bar", Pathname2.new("C:\\foo\\bar\\baz").parent)
    assert_equal("C:\\", Pathname2.new("C:\\foo").parent)
  end

  test "parent returns expected results for a relative path" do
    assert_equal("foo", Pathname2.new("foo\\bar").parent)
  end

  test "parent method returns root if already a root path" do
    assert_equal("C:\\", Pathname2.new("C:\\").parent)
    assert_equal("\\\\foo\\bar", Pathname2.new("//foo/bar").parent)
  end

  def teardown
    @path = nil
  end
end
