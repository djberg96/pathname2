########################################################################
# test_version.rb
#
# Universal test file that tests for the proper version number.
########################################################################
require 'pathname2'
require 'test-unit'

class TC_Pathname2_Version < Test::Unit::TestCase
  test "version is set to expected value" do
    assert_equal('2.0.0', Pathname2::VERSION)
  end

  test "version is frozen" do
    assert_true(Pathname2::VERSION.frozen?)
  end
end
