########################################################################
# test_misc.rb
#
# Test suite for miscellaneous items that didn't warrant their own
# test file.
########################################################################
require 'pathname2'
require 'test-unit'

class MyPathname2 < Pathname2; end

class TC_Pathname2_Misc < Test::Unit::TestCase
  def setup
    @mypath = MyPathname2.new(Dir.pwd)
  end

  test "subclasses return instances of that subclass" do
    assert_kind_of(MyPathname2, @mypath)
    assert_kind_of(MyPathname2, @mypath + MyPathname2.new('foo'))
    assert_kind_of(MyPathname2, @mypath.realpath)
  end

  test "custom pn method works as expected" do
    assert_respond_to(Kernel, :pn)
    assert_nothing_raised{ pn{'c:\foo'} }
    assert_kind_of(Pathname2, pn{'c:\foo'})
    assert_equal('c:\foo', pn{'c:\foo'})
  end

  def teardown
    @mypath = nil
  end
end
