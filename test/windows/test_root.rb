########################################################################
# test_root.rb
#
# Test suite for the Pathname#root method
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname_Root < Test::Unit::TestCase
  def setup
    @abs_path = Pathname.new('C:\\Program Files')
    @unc_path = Pathname.new('\\\\foo\\bar\\baz')
    @rel_path = Pathname.new('foo\\bar\\baz')
  end

  test 'root method returns expected results for absolute paths' do
    assert_equal('C:\\', @abs_path.root)
  end

  test 'root method returns expected results for paths with forward slashes' do
    assert_equal('C:\\', Pathname.new('C:/Program Files').root)
  end

  test 'root method returns expected results for unc paths' do
    assert_equal('\\\\foo\\bar', @unc_path.root)
    assert_equal('\\\\foo', Pathname.new('\\\\foo').root)
    assert_equal('\\\\', Pathname.new('\\\\').root)
  end

  test 'root method returns dot for relative paths' do
    assert_equal('.', @rel_path.root)
  end

  test 'root method returns expected result for root path' do
    assert_equal('Z:\\', Pathname.new('Z:\\').root)
    assert_equal('\\\\foo\\bar', Pathname.new('\\\\foo\\bar').root)
  end

  test 'root method returns expected result for empty string' do
    assert_equal('.', Pathname.new('').root)
  end

  test 'root method returns expected result for dot and dotdot' do
    assert_equal('.', Pathname.new('..').root)
    assert_equal('.', Pathname.new('.').root)
  end

  test 'root method is not destructive' do
    str = 'C:/Program Files'
    assert_nothing_raised{ Pathname.new(str).root }
    assert_equal('C:/Program Files', str)
  end

  def teardown
    @abs_path = nil
    @unc_path = nil
    @rel_path = nil
  end
end
