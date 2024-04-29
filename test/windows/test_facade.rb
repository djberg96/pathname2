########################################################################
# test_facade.rb
#
# Test suite for the various facade methods.
########################################################################
require 'test-unit'
require 'pathname2'

class TC_Pathname_Facade < Test::Unit::TestCase
  def setup
    @path = Pathname.new('C:/Program Files')
  end

  test 'file facade methods are defined' do
    File.methods(false).each{ |m| assert_respond_to(@path, m.to_sym) }
  end

  test 'dir facade methods are defined' do
    Dir.methods(false).each{ |m| assert_respond_to(@path, m.to_sym) }
  end

  test 'fileutils facade methods are defined' do
    methods = FileUtils.public_instance_methods
    methods -= File.methods(false)
    methods -= Dir.methods(false)

    # Ruby 1.9.x and 2.0 incorrectly made some of these methods public
    methods.delete_if{ |m|
      m =~ /stream|^ln|identical\?|mode_to_s|^sh|ruby|safe_ln|split_all/i
    }

    methods.each{ |method|
      assert_respond_to(@path, method.to_sym)
    }
  end

  test 'find facade works as expected' do
    assert_respond_to(@path, :find)
    assert_nothing_raised{ @path.find{} }

    Pathname.new(Dir.pwd).find{ |f|
      Find.prune if f.match('git')
      assert_kind_of(Pathname, f)
    }
  end

  test 'custom io methods are defined' do
    assert_respond_to(@path, :foreach)
    assert_respond_to(@path, :read)
    assert_respond_to(@path, :readlines)
    assert_respond_to(@path, :sysopen)
  end

  test 'exist? facade works as expected' do
    assert_respond_to(@path, :exist?)
    assert_nothing_raised{ @path.exist? }
    assert_true(Pathname.new('C:\\').exist?)
    assert_false(Pathname.new('X:\\foo\\bar\\baz').exist?)
  end

  def teardown
    @path = nil
  end
end
