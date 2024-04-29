########################################################################
# test_is_unc.rb
#
# Test suite for the Pathname#unc? method
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname_IsUNC < Test::Unit::TestCase
  def setup
    @abs_path = Pathname.new('C:\\Program Files')
    @unc_path = Pathname.new('\\\\foo\\bar\\baz')
    @rel_path = Pathname.new('foo\\bar\\baz')
  end

  test 'unc? basic functionality' do
    assert_respond_to(@unc_path, :unc?)
    assert_nothing_raised{ @unc_path.unc? }
    assert_boolean(@unc_path.unc?)
  end

  test 'unc? method returns false for non-unc paths' do
    assert_false(Pathname.new('C:\\').unc?)
    assert_false(Pathname.new('C:\\Program Files').unc?)
    assert_false(Pathname.new('C:\\\\Program Files').unc?)
    assert_false(Pathname.new('C:/Program Files/File.txt').unc?)
    assert_false(Pathname.new('C:\\Program Files\\File[12].txt').unc?)
    assert_false(Pathname.new('foo\\bar').unc?)
    assert_false(Pathname.new('.').unc?)
  end

  test 'unc? method returns true for unc paths' do
    assert_true(Pathname.new('\\\\foo\\bar').unc?)
    assert_true(Pathname.new('//foo/bar').unc?)
    assert_true(Pathname.new('\\\\foo\\bar\\baz').unc?)
    assert_true(Pathname.new('\\\\foo').unc?)
    assert_true(Pathname.new('\\\\').unc?)
  end

  test 'unc? method is not destructive' do
    str = '//foo/bar'
    assert_nothing_raised{ Pathname.new(str).unc? }
    assert_equal('//foo/bar', str)
  end

  def teardown
    @abs_path = nil
    @unc_path = nil
    @rel_path = nil
  end
end
