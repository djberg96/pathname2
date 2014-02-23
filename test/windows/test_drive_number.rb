########################################################################
# test_drive_number.rb
#
# Test suite for the Pathname#drive_number method
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname_Root < Test::Unit::TestCase
  def setup
    @abs_path = Pathname.new("C:\\Program Files")
    @unc_path = Pathname.new("\\\\foo\\bar\\baz")
    @rel_path = Pathname.new("foo\\bar\\baz")
  end

  test "drive_number method returns expected results for absolute paths" do
    assert_equal(2, @abs_path.drive_number)
  end

  test "drive_number method returns expected results for paths with forward slashes" do
    assert_equal(2, Pathname.new("C:/Program Files").drive_number)
  end

  test "drive_number method returns expected results for unc paths" do
    assert_nil(@unc_path.drive_number)
    assert_nil(Pathname.new("\\\\foo").drive_number)
    assert_nil(Pathname.new("\\\\").drive_number)
  end

  test "drive_number method returns dot for relative paths" do
    assert_nil(@rel_path.drive_number)
  end

  test "drive_number method returns expected result for root path" do
    assert_equal(25, Pathname.new("Z:\\").drive_number)
  end

  test "drive_number method returns expected result for empty string" do
    assert_nil(Pathname.new("").drive_number)
  end

  test "drive_number method returns expected result for dot and dotdot" do
    assert_nil(Pathname.new(".").drive_number)
    assert_nil(Pathname.new("..").drive_number)
  end

  test "drive_number method is not destructive" do
    str = 'C:/Program Files'
    assert_nothing_raised{ Pathname.new(str).drive_number }
    assert_equal('C:/Program Files', str)
  end

  def teardown
    @abs_path = nil
    @unc_path = nil
    @rel_path = nil
  end
end
