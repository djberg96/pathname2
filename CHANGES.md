## 1.8.4 - 19-Jan-2021
* Cleaned up the Rubocop warnings.
* Added a Gemfile.
* Some minor updates to the gemspec and Rakefile.

## 1.8.3 - 30-Aug-2020
* Updated the tests to match the version. Thanks go to Cédric Boutillier for the spot.
* Fixed a redefinition warning for the :children method.
* Fixed a Fixnum deprecation warning.

## 1.8.2 - 21-Jul-2020
* Added a LICENSE file as required by the Apache-2.0 license.

## 1.8.1 - 31-Jan-2019
* The VERSION constant is now frozen.
* Added metadata to the gemspec.
* Fixed missing hyphen in license name.
* Updated cert, should be good for about 10 years.

## 1.8.0 - 19-Jun-2016
* Changed license to Apache-2.0.
* Some cleanup and updates to the Rakefile and benchmarks.
* Refactored some realpath tests so they're not touching system files like
  /dev/stdin any more. Thanks go to Michael R. Crusoe for pointing out the
  potential pitfalls of doing that.

## 1.7.4 - 7-Sep-2015
* This gem is now signed.
* Rakefile now assumes Rubygems 2.x for some tasks.

## 1.7.3 - 24-Apr-2014
* The basename and dirname methods now return Pathname objects.

## 1.7.2 - 23-Apr-2014
* The join and expand_path methods now return Pathname objects.

## 1.7.1 - 28-Mar-2014
* Updated gemspec for Windows vs Unix.
* Updated README and MANIFEST.

## 1.7.0 - 28-Mar-2014
* Windows now uses FFI internally instead of win32-api.
* Added a custom pretty_print method for the pp library.
* Reorganized the test suite for Windows, and added many
  more test tasks to the Rakefile.

## 1.6.5 - 19-Sep-2011
* Added the String#to_path instance method. This returns a Pathname
  object.
* The architecture for the Windows gem is now "universal", and some
  gemspec dependencies were simplified.

## 1.6.4 - 20-Jan-2011
* Explicitly remove the Pathname const if it is already defined in order
  to avoid a superclass mismatch error. This library assumes that if you
  require pathname2, you want my version of the Pathname class.
* Updated URI handling for Ruby 1.9.x.
* Added the Pathname() method, a synonym for Pathname.new.
* Some Rakefile and gemspec tweaks.
* Some updates to the test suite, including some specifically for Windows 7.

## 1.6.3 - 2-Oct-2009
* Updated Windows platform handling code to include mingw and cygwin.
* Added the :gem rake task.
* Minor gemspec updates.
* Some minor test suite updates.

## 1.6.2 - 4-Aug-2009
* Now compatible with Ruby 1.9.x.
* License changed to Artistic 2.0.
* Added the Pathname.pwd method as a synonym for Pathname.new(Dir.pwd).
* Modified Pathname#dirname so that you can specify a level that indicates
  how many levels up you want to retrieve. For example, if your path was
  '/usr/local/bin', then path.dirname(2) would return '/usr'.
* Now compatible with Ruby 1.9.x.
* Bumped required version of the facade library to 1.0.4.

## 1.6.1 - 8-Nov-2008
* Added the Pathname#[] method, which accepts an index, an index plus a
  length, or a range, and returns appropriate the path element(s).
* Refactoring the platform checking in the test suite to use rbconfig instead
  of RUBY_PLATFORM.
* More inline documentation examples.

## 1.6.0 - 13-July-2008
* The facade for ftools (and ftools itself) has been removed. The ftools
  library is deprecated in favor of FileUtils.
* PathnameError is now Pathname::Error.
* Bug fix for Pathname#relative_path_from for MS Windows. Thanks go to an
  anonymous user for the spot.
* Fixed a bug where frozen strings would raise an error on MS Windows.
* The code is now -w clean.
* Removed the C version as part of the release because it was just too
  difficult to maintain both versions. The C code remains in CVS, however.
* Changed platform checking to use rbconfig instead of RUBY_PLATFORM to avoid
  potential issues with other Ruby implementation.

## 1.5.2 - 9-Mar-2007
* Bug fix for the Pathname#realpath method where it was not handling recursive
  symlinks. The C version was also fixed, but it only affected platforms that
  don't have the realpath() function.
* Added a test for recursive symlinks (for Solaris, anyway).
* Updated the docs for Pathname#realpath.
* Minor speed enhancements for the C version and the elimination of one
  (potential) segfault.
* Added a 'Future Plans' section to the README.
* Added a Rakefile. You can now build, clean, and test and install (both the
  pure Ruby and C versions).

## 1.5.1 - 28-Aug-2006
* Added the Kernel#pn method as a shortcut for Pathname.new.
* The Pathname#readlink now properly handles symbolic links.  The 'fix'
  from 1.4.4 did not work.
* The C extension uses your system's realpath() function for the
  Pathname#readlink method if it has one.
* Added the '/' alias for '+'.  So, p1 / p2 is the same as p1 + p2.
* The windows-pr package is now required on MS Windows.

## 1.5.0 - 17-Apr-2006
* Better subclass handling, in that some methods that previously returned
  hardcoded Pathname.new now return self.class.new.
* File URL's are now handled on Unix as well (using the 'uri' package).
* Some comment changes/clarifications.
* Added the PathnameError class to the pure Ruby version.

## 1.4.4 - 23-Mar-2006
* If the path is a symbolic link the Pathname#realpath method
  now returns the absolute path of that link, i.e. the result
  of File.readlink (as a Pathname object).

## 1.4.3 - 3-Mar-2006
* Added the Pathname#realpath method.

## 1.4.2 - 22-Feb-2006
* Fixed the Pathname#relative_path_from method for Windows.  This really only
  affected edge cases that you probably never saw anyway.
* Added corresponding tests for Windows.

## 1.4.1 - 18-Feb-2006
* Added the Pathname#parent method.
* Added the Pathname#relative_path_from method.
* Bug fix for Pathname#pstrip on *nix.
* Corresponding test suite additions.

## 1.4.0 - 19-Dec-2005
* Added destructive and non-destructive methods for some methods - pstrip,
  pstrip!, undecorate, undecorate!, clean and clean!.
* Added a C extension version of this package.  You can use the C version
  instead of the pure Ruby version instead.  See the README for more details.
* Fixed bug in the root method where the result wasn't guaranteed to be a
  Pathname class.
* Fixed bugs in Windows version where the receiver was inadvertantly modified
  in some cases, and added tests to check for this in the future.
* Modified the Dir.glob facade so that it (temporarily) changes to the path
  directory, globs on that path, then returns to the original directory.
* Added the bench_pathname.rb script to let you benchmark all Pathname
  methods.

## 1.3.1 - 21-Nov-2005
* Added the Pathname#children method.
* Added tests for the Pathname#children method.

## 1.3.0 - 28-Oct-2005
* Added the short_path and long_path methods for MS Windows.
* Optimization for the '+' method on Unix.
* Added some examples under the 'examples' directory.
* More tests added and some minor changes to the test suite in general.

## 1.2.1 - 1-Sep-2005
* Bug fix for the ascend and descend methods wrt Windows and UNC paths.
* More tests added for ascend and descend methods.

## 1.2.0 - 29-Aug-2005
* Added the 'ascend' and 'descend' methods.
* Added corresponding test suite additions.

## 1.1.0 - 13-Jul-2005
* Added the 'find' facade.

## 1.0.0 - 11-Jun-2005
* Initial release
