[![Ruby](https://github.com/djberg96/pathname2/actions/workflows/ruby.yml/badge.svg)](https://github.com/djberg96/pathname2/actions/workflows/ruby.yml)

## Description
A drop-in replacement for the current Pathname class.

## Prerequisites
* facade
* ffi (Windows only)
* test-unit (testing only)
   
## Installation
`gem install pathname2`

## Adding the Trusted Cert

`gem cert --add <(curl -Ls https://raw.githubusercontent.com/djberg96/pathname2/main/certs/djberg96_pub.pem)`

## Synopsis
```ruby
require 'pathname2'

# Unix
path1 = Pathname.new("/foo/bar/baz")
path2 = Pathname.new("../zap")

path1 + path2 # "/foo/bar/zap"
path1 / path2 # "/foo/bar/zap" (same as +)
path1.exists? # Does this path exist?
path1.dirname # "/foo/bar"
path1.to_a    # ['foo','bar','baz']

# Windows
path1 = Pathname.new("C:/foo/bar/baz")
path2 = Pathname.new("../zap")

path1 + path2 # "C:\\foo\\bar\\zap"
path1.root    # "C:\\"
path1.to_a    # ['C:','foo','bar','baz']
```

## Windows Notes
All forward slashes are converted to backslashes for Pathname objects.

## Differences between Unix and Windows
  If your pathname consists solely of ".", or "..", the return
  value for Pathname#clean will be different. On Win32, "\\" is returned,
  while on Unix "." is returned.  I consider this an extreme edge case and
  will not worry myself with it.

## Differences between Pathname in the standard library and this version
* It is a subclass of String (and thus, mixes in Enumerable).
* It has sensical `to_a` and `root` instance methods.
* It works on Windows and Unix. The current implementation does not work
  with Windows path names very well, and not at all when it comes to UNC
  paths.
* The `Pathname#cleanpath` method works differently - it always returns
  a canonical pathname. In addition, there is no special consideration
  for symlinks (yet), though I'm not sure it warrants it.
* The `Pathname#+` method auto cleans.
* It uses a facade for all File and Dir methods, as well as most FileUtils
  methods.
* `Pathname#clean` works slightly differently. In the stdlib version,
  `Pathname#clean("../a")` returns "../a". In this version, it returns "a".
  This affects other methods, such as `Pathname#relative_path_from`.
* Accepts file urls and converts them to paths automatically, e.g.
  file:///foo%20bar/baz becomes '/foo/bar/baz'.
* Adds a Kernel level `pn` method as a shortcut.
* Allows you to add paths together with the '/' operator.
     
## Method Priority
Because there is some overlap in method names between File, Dir, and
FileUtils, the priority is as follows:
   
* File
* Dir
* FileUtils
   
In other words, whichever of these defines a given method first is the
method that is used by the pathname2 library.
   
## Known Issues
On MS Windows, some methods may not work on pathnames greater than 260
characters because of internal function limitations.
   
Any issues you find should be reported on the project page at
https://github.com/djberg96/pathname2

## Future Plans
None at this time. Suggestions welcome.
   
## License
Apache-2.0
   
## Copyright
(C) 2003-2021 Daniel J. Berger
All rights reserved.

## Warranty
This library is provided "as is" and without any express or
implied warranties, including, without limitation, the implied
warranties of merchantability and fitness for a particular purpose.

## Author
Daniel J. Berger
