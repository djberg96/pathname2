########################################################################
# example_pathname2.rb
#
# Some examples to demonstrate the behavior of the pathname2 library.
########################################################################
require 'pathname2'

puts "VERSION: " + Pathname2::VERSION

path1 = Pathname2.new("foo/bar")
path2 = Pathname2.new("baz/blah")

path3 = Pathname2.new("foo/../bar")
path4 = Pathname2.new("../baz")

p path1 + path2 # foo/bar/baz/blah
p path3 + path4 # baz

# Shortcut syntax
path = pn{ "C:\\Documents and Settings\\snoopy\\My Documents" }

p path[0]    # C:
p path[1]    # Documents and Settings
p path[0,2]  # C:\\Documents and Settings
p path[0..2] # C:\\Documents and Settings\\snoopy
