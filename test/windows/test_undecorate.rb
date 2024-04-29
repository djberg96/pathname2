########################################################################
# test_undecorate.rb
#
# Test suite for the Pathname#undecorate method
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname_Undecorate < Test::Unit::TestCase
  def setup
    @std = Pathname.new('C:/Path/File.txt')
  end

  test 'undecorate basic functionality' do
    assert_respond_to(@std, :undecorate)
    assert_nothing_raised{ @std.undecorate }
  end

  test 'undecorate returns a Pathname object' do
    assert_kind_of(Pathname, @std.undecorate)
  end

  test 'undecorate method returns an already undecorated path unchanged' do
    assert_equal('C:\Path\File.txt', Pathname.new('C:\Path\File.txt').undecorate)
    assert_equal('\\foo\bar', Pathname.new('\\foo\bar').undecorate)
  end

  test 'undecorate returns expected result for standard path' do
    assert_equal('C:\Path\File', Pathname.new('C:\Path\File[12]').undecorate)
    assert_equal('C:\Path\[3].txt', Pathname.new('C:\Path\[3].txt').undecorate)
  end

  test 'undecorate returns expected result for UNC path' do
    assert_equal('\\foo\bar.txt', Pathname.new('\\foo\bar[5].txt').undecorate)
    assert_equal('\\foo\bar', Pathname.new('\\foo\bar[5]').undecorate)
  end

  test 'undecorate does not modify the original string' do
    str = 'C:/Path/File.txt'
    assert_nothing_raised{ Pathname.new(str).undecorate }
    assert_equal('C:/Path/File.txt', str)
  end

  def teardown
    @std = nil
  end
end
