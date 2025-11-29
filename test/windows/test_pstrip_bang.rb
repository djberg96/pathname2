########################################################################
# test_pstrip_bang.rb
#
# Test suite for the Pathname2#pstrip! method
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname2_PstripBang < Test::Unit::TestCase
  def setup
    @path = Pathname2.new("C:/Program Files////")
  end

  test "pstrip! basic functionality" do
    assert_respond_to(@path, :pstrip!)
    assert_nothing_raised{ @path.pstrip! }
    assert_kind_of(Pathname2, @path.pstrip!)
  end

  test "pstrip! returns expected result for path with trailing slashes" do
    assert_equal("C:\\Program Files", @path.pstrip!)
    assert_equal("C:\\Program Files", Pathname2.new("C:\\Program Files\\\\").pstrip!)
    assert_equal("C:\\Program Files", Pathname2.new("C:\\Program Files//\\").pstrip!)
  end

  test "pstrip! returns the path as is if it does not contain a trailing slash" do
    assert_equal("C:\\Program Files", Pathname2.new("C:\\Program Files").pstrip!)
    assert_equal("", Pathname2.new("").pstrip!)
  end

  test "pstrip! alters pathname object" do
    path = Pathname2.new('C:/Program Files////')
    assert_nothing_raised{ path.pstrip! }
    assert_equal('C:\Program Files', path.to_s)
  end

  test "pstrip! method does not modify original constructor argument" do
    str = 'C:/Program Files////'
    assert_nothing_raised{ Pathname2.new(str).pstrip! }
    assert_equal('C:/Program Files////', str)
  end

  def teardown
    @path = nil
  end
end
