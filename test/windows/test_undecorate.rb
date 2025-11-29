########################################################################
# test_undecorate.rb
#
# Test suite for the Pathname2#undecorate method
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname2_Undecorate < Test::Unit::TestCase
  def setup
    @std = Pathname2.new('C:/Path/File.txt')
  end

  test "undecorate basic functionality" do
    assert_respond_to(@std, :undecorate)
    assert_nothing_raised{ @std.undecorate }
  end

  test "undecorate returns a Pathname2 object" do
    assert_kind_of(Pathname2, @std.undecorate)
  end

  test "undecorate method returns an already undecorated path unchanged" do
    assert_equal('C:\Path\File.txt', Pathname2.new('C:\Path\File.txt').undecorate)
    assert_equal('\\foo\bar', Pathname2.new('\\foo\bar').undecorate)
  end

  test "undecorate returns expected result for standard path" do
    assert_equal('C:\Path\File', Pathname2.new('C:\Path\File[12]').undecorate)
    assert_equal('C:\Path\[3].txt', Pathname2.new('C:\Path\[3].txt').undecorate)
  end

  test "undecorate returns expected result for UNC path" do
    assert_equal('\\foo\bar.txt',Pathname2.new('\\foo\bar[5].txt').undecorate)
    assert_equal('\\foo\bar', Pathname2.new('\\foo\bar[5]').undecorate)
  end

  test "undecorate does not modify the original string" do
    str = 'C:/Path/File.txt'
    assert_nothing_raised{ Pathname2.new(str).undecorate }
    assert_equal('C:/Path/File.txt', str)
  end

  def teardown
    @std = nil
  end
end
