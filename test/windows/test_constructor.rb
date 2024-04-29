########################################################################
# test_constructor.rb
#
# Various tests for the Pathname.new method.
########################################################################
require 'pathname2'
require 'test-unit'

class TC_Pathname_Constructor < Test::Unit::TestCase
  def setup
    @abs_path = 'C:/Users'
    @rel_path = 'Users'
    @url_path = 'file:///C:/Documents%20and%20Settings'
  end

  test 'constructor handles absolute paths properly' do
    assert_nothing_raised{ Pathname.new(@abs_path) }
    assert_equal('C:\\Users', Pathname.new(@abs_path).to_s)
  end

  test 'constructor handles relative paths properly' do
    assert_nothing_raised{ Pathname.new(@rel_path) }
    assert_equal('Users', Pathname.new(@rel_path).to_s)
  end

  test "constructor handles file URL's properly" do
    assert_nothing_raised{ Pathname.new(@url_path) }
    assert_equal('C:\\Documents and Settings', Pathname.new(@url_path).to_s)
  end

  test 'constructor returns a Pathname object' do
    assert_kind_of(Pathname, Pathname.new(@abs_path))
  end

  test 'constructor handles frozen arguments without issue' do
    assert_nothing_raised{ Pathname.new(@abs_path.freeze) }
  end

  test 'constructor raises an error if string argument is too long' do
    assert_raise(ArgumentError){ Pathname.new('foo' * 1000) }
  end

  def teardown
    @url_path = nil
    @rel_path = nil
    @abs_path = nil
  end
end
