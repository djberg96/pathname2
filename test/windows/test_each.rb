########################################################################
# test_each.rb
#
# Test suite for the Pathname2#each method.
########################################################################
require 'pathname2'
require 'test-unit'

class TC_Pathname2_Each < Test::Unit::TestCase
  def setup
    @path = Pathname2.new("C:/Users/foo/bar")
  end

  test "each basic functionality" do
    assert_respond_to(@path, :each)
    assert_nothing_raised{ @path.each{} }
  end

  test "each returns the expected results" do
    arr = []
    @path.each{ |e| arr << e }
    assert_equal(['C:', 'Users', 'foo', 'bar'], arr)
  end

  def teardown
    @path = nil
  end
end
