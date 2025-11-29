########################################################################
# test_aref.rb
#
# Test suite for the Pathname2#[] method.
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname2_Aref < Test::Unit::TestCase
  def setup
    @path = Pathname2.new("C:/Program Files/Windows NT/Accessories")
  end

  test "[] with index works as expected" do
    assert_equal("C:", @path[0])
    assert_equal("Program Files", @path[1])
    assert_equal("Accessories", @path[-1])
    assert_nil(@path[10])
  end

  test "[] with range argument works as expected" do
    assert_equal("C:\\Program Files", @path[0..1])
    assert_equal("C:\\Program Files\\Windows NT", @path[0..2])
    assert_equal("Program Files\\Windows NT", @path[1..2])
    #assert_equal(@path, @path[0..-1]) # TODO: Spews tons of warnings
  end

  test "[] with index and length works as expected" do
    assert_equal("C:", @path[0,1])
    assert_equal("C:\\Program Files", @path[0,2])
    assert_equal("Program Files\\Windows NT", @path[1,2])
  end

  def teardown
    @path = nil
  end
end
