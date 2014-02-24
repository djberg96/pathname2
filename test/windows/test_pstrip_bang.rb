########################################################################
# test_pstrip_bang.rb
#
# Test suite for the Pathname#pstrip! method
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname_PstripBang < Test::Unit::TestCase
  def setup
    @path = Pathname.new("C:/Program Files////")
  end

  test "pstrip! basic functionality" do
    assert_respond_to(@path, :pstrip!)
    assert_nothing_raised{ @path.pstrip! }
    assert_kind_of(Pathname, @path.pstrip!)
  end

  test "pstrip! returns expected result for path with trailing slashes" do
    assert_equal("C:/Program Files", @path.pstrip!)
    assert_equal("C:\\Program Files", Pathname.new("C:\\Program Files\\\\").pstrip!)
    assert_equal("C:\\Program Files", Pathname.new("C:\\Program Files//\\").pstrip!)
  end

  test "pstrip! returns the path as is if it does not contain a trailing slash" do
    assert_equal("C:\\Program Files", Pathname.new("C:\\Program Files").pstrip!)
    assert_equal("", Pathname.new("").pstrip!)
  end

  test "pstrip! alters pathname object" do
    path = Pathname.new('C:/Program Files////')
    assert_nothing_raised{ path.pstrip! }
    assert_equal('C:/Program Files', path.to_s)
  end

  test "pstrip! method does not modify original constructor argument" do
    str = 'C:/Program Files////'
    assert_nothing_raised{ Pathname.new(str).pstrip! }
    assert_equal('C:/Program Files////', str)
  end

  def teardown
    @abs_path = nil
    @unc_path = nil
    @rel_path = nil
  end
end
