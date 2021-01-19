########################################################################
# test_version.rb
#
# Universal test file that tests for the proper version number.
########################################################################
require 'pathname2'
require 'test-unit'

class TC_Pathname_Version < Test::Unit::TestCase
  test "version is set to expected value" do
    assert_equal('1.8.4', Pathname::VERSION)
  end

  test "version is frozen" do
    assert_true(Pathname::VERSION.frozen?)
  end
end
