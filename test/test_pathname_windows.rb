##########################################################################
# test_pathname_win.rb
#
# MS Windows test suite for the Pathname class. To test explicitly
# against the C extension pass the letter 'c' as an argument. You should
# use the 'rake test' task to run this test suite.
###########################################################################
require 'rubygems'
gem 'test-unit'

require 'facade'
require 'pathname2'
require 'test/unit'
require 'windows/system_info'

class MyPathname < Pathname; end

class TC_Pathname_MSWin < Test::Unit::TestCase
  include Windows::SystemInfo

  def setup
    @fpath = Pathname.new("C:/Program Files/Windows NT/Accessories")
    @bpath = Pathname.new("C:\\Program Files\\Windows NT\\Accessories")
    @dpath = Pathname.new("C:\\Program Files\\File[5].txt")
    @spath = Pathname.new("C:\\PROGRA~1\\WINDOW~1\\ACCESS~1")
    @upath = Pathname.new("\\\\foo\\bar\\baz")
    @npath = Pathname.new("foo\\bar\\baz")
    @rpath = Pathname.new("Z:\\")
    @xpath = Pathname.new("\\\\foo\\bar")
    @ypath = Pathname.new("\\\\foo")
    @zpath = Pathname.new("\\\\")
    @epath = Pathname.new("")
    @ppath = Pathname.new("C:\\foo\\bar\\")
    @cpath = Pathname.new("C:\\foo\\..\\bar\\.\\baz")
    @tpath = Pathname.new("C:\\foo\\bar")

    @url_path = Pathname.new("file:///C:/Documents%20and%20Settings")
    @cur_path = Pathname.new(Dir.pwd)

    @mypath = MyPathname.new("C:\\Program Files")

    @abs_array = []
    @rel_array = []
    @unc_array = []
  end

  def test_version
    assert_equal('1.7.0', Pathname::VERSION)
  end

  # Convenience method for test_spaceship operator
  def assert_pathname_cmp(int, s1, s2)
    p1 = Pathname.new(s1)
    p2 = Pathname.new(s2)
    result = p1 <=> p2
    assert_equal(int, result)
  end

  def test_file_urls
    assert_equal("C:\\Documents and Settings", @url_path)
    assert_raises(Pathname::Error){ Pathname.new('http://rubyforge.org') }
  end

  def test_each
    array = []

    assert_respond_to(@fpath, :each)
    assert_nothing_raised{ @fpath.each{ |e| array.push(e) } }
    assert_equal(["C:", "Program Files", "Windows NT", "Accessories"], array)
  end

  def test_immutability
    path = "C:\\Program Files\\foo\\bar".freeze
    assert_true(path.frozen?)
    assert_nothing_raised{ Pathname.new(path) }
    assert_nothing_raised{ Pathname.new(path).root }
  end

  def test_children
    assert_respond_to(@cur_path, :children)
    assert_nothing_raised{ @cur_path.children }
    assert_kind_of(Array, @cur_path.children)

    # Delete Eclipse related files
    children = @cur_path.children
    children.delete_if{ |e| File.basename(e) == "CVS" }
    children.delete_if{ |e| File.basename(e) == ".git" }
    children.delete_if{ |e| File.basename(e) == ".gitignore" }
    children.delete_if{ |e| File.basename(e) == ".cvsignore" }
    children.delete_if{ |e| File.basename(e) == ".project" }
    children.delete_if{ |e| File.basename(e) == ".loadpath" }

    assert_equal(
      [
        Dir.pwd + "/benchmarks",
        Dir.pwd + "/CHANGES",
        Dir.pwd + "/examples",
        Dir.pwd + "/lib",
        Dir.pwd + "/MANIFEST",
        Dir.pwd + "/pathname2.gemspec",
        Dir.pwd + "/Rakefile",
        Dir.pwd + "/README",
        Dir.pwd + "/test"
      ].map{ |e| e.tr("/", "\\") },
      children
    )

    # Delete Eclipse related files
    children = @cur_path.children(false)
    children.delete("CVS")
    children.delete(".git")
    children.delete(".gitignore")
    children.delete(".cvsignore")
    children.delete(".project")
    children.delete(".loadpath")

    assert_equal(
      [
        "benchmarks", "CHANGES", "examples", "lib", "MANIFEST",
        "pathname2.gemspec", "Rakefile", "README", "test"
      ],
      children
    )
  end

  # Ensures that subclasses return the subclass as the class, not a hard
  # coded Pathname.
  def test_subclasses
    assert_kind_of(MyPathname, @mypath)
    assert_kind_of(MyPathname, @mypath + MyPathname.new('foo'))
    assert_kind_of(MyPathname, @mypath.realpath)
    assert_kind_of(MyPathname, @mypath.children.first)
  end

  # Test to ensure that the pn{ } shortcut works
  #
  def test_kernel_method
    assert_respond_to(Kernel, :pn)
    assert_nothing_raised{ pn{'c:\foo'} }
    assert_kind_of(Pathname, pn{'c:\foo'})
    assert_equal('c:\foo', pn{'c:\foo'})
  end

  def teardown
    @fpath = nil
    @bpath = nil
    @dpath = nil
    @spath = nil
    @upath = nil
    @npath = nil
    @rpath = nil
    @xpath = nil
    @ypath = nil
    @zpath = nil
    @epath = nil
    @ppath = nil
    @cpath = nil
    @tpath = nil

    @cur_path = nil

    @abs_array.clear
    @rel_array.clear
    @unc_array.clear
  end
end
