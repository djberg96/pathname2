########################################################################
# test_children.rb
#
# Test suite for the Pathname#children method.
########################################################################
require 'pathname2'
require 'test-unit'

class TC_Pathname_Children < Test::Unit::TestCase
  def setup
    @dir  = 'foo'
    @path = Pathname.new(File.dirname(File.dirname(__FILE__)))

    Dir.mkdir(@dir)
    Dir.chdir(@dir){
      FileUtils.touch('alpha')
      FileUtils.touch('beta')
      FileUtils.touch('gamma')
    }
  end

  test 'children basic functionality' do
    assert_respond_to(@path, :children)
    assert_nothing_raised{ @path.children{} }
    assert_kind_of(Array, @path.children)
  end

  test 'children method returns expected results' do
    path = Pathname.new(@dir)
    assert_equal(%w[foo\alpha foo\beta foo\gamma], path.children)
  end

  test 'each result of the children method is a Pathname object' do
    path = Pathname.new(@dir)
    assert_kind_of(Pathname, path.children.first)
  end

  def teardown
    FileUtils.rm_rf(@dir) if File.exist?(@dir)
    @path = nil
  end
end
