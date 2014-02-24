########################################################################
# test_short_path.rb
#
# Test suite for the Pathname#short_path method
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname_ShortPath < Test::Unit::TestCase
  def setup
    @abs_path = Pathname.new("C:\\Program Files")
  end

  test "short_path basic functionality" do
    assert_respond_to(@abs_path, :short_path)
    assert_nothing_raised{ @abs_path.short_path }
    assert_kind_of(String, @abs_path.short_path)
  end

  test "short_path returns the expected result" do
    assert_equal("C:\\PROGRA~1", @abs_path.short_path)
  end

  test "short_path returns the same string if it's already short" do
    assert_equal("C:\\", Pathname.new("C:/").short_path)
  end

  test "short_path fails if the path does not exist" do
    assert_raise(Errno::ESRCH){ Pathname.new("C:/Bogus/AlsoBogus").short_path }
  end

  test "short_path method is not destructive" do
    str = 'C:/Program Files'
    assert_nothing_raised{ Pathname.new(str).short_path }
    assert_equal('C:/Program Files', str)
  end

  def teardown
    @abs_path = nil
  end
end
