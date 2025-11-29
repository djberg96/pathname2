########################################################################
# test_long_path.rb
#
# Test suite for the Pathname2#long_path method
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname2_LongPath < Test::Unit::TestCase
  def setup
    @abs_path = Pathname2.new("C:\\PROGRA~1")
  end

  test "long_path basic functionality" do
    assert_respond_to(@abs_path, :long_path)
    assert_nothing_raised{ @abs_path.long_path }
    assert_kind_of(String, @abs_path.long_path)
  end

  test "long_path returns the expected result" do
    assert_equal("C:\\Program Files", @abs_path.long_path)
  end

  test "long_path returns the same string if it's already long" do
    assert_equal("C:\\Program Files", Pathname2.new("C:/Program Files").long_path)
  end

  test "long_path fails if the path does not exist" do
    assert_raise(Errno::ESRCH){ Pathname2.new("C:/Bogus/AlsoBogus").long_path }
  end

  test "long_path method is not destructive" do
    str = 'C:/Program Files'
    assert_nothing_raised{ Pathname2.new(str).long_path }
    assert_equal('C:/Program Files', str)
  end

  def teardown
    @abs_path = nil
  end
end
