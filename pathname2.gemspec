require 'rubygems'

Gem::Specification.new do |spec|
  spec.name        = 'pathname2'
  spec.version     = '1.6.4'
  spec.author      = 'Daniel J. Berger'
  spec.license     = 'Artistic 2.0'
  spec.email       = 'djberg96@gmail.com'
  spec.homepage    = 'http://www.rubyforge.org/projects/shards'
  spec.summary     = 'An alternate implementation of the Pathname class'
  spec.has_rdoc    = true
  spec.files       = Dir['**/*'].reject{ |f| f.include?('git') }

  spec.extra_rdoc_files  = ['README', 'CHANGES', 'MANIFEST']
  spec.rubyforge_project = 'shards' 

  spec.add_dependency('facade', '>= 1.0.4')
  spec.add_development_dependency('test-unit', '>= 2.1.2')
   
  if File::PATH_SEPARATOR == ';'
    spec.test_file = 'test/test_pathname_windows.rb'
    spec.add_dependency('windows-pr', '>= 1.1.2')
    spec.platform = Gem::Platform::CURRENT
  else
    spec.test_file = 'test/test_pathname.rb'
  end
   
  spec.description = <<-EOF
    The pathname2 library provides an implementation of the Pathname
    class different from the one that ships as part of the Ruby standard
    library. It is a subclass of String, though several methods have been
    overridden to better fit a path context. In addition, it supports file
    URL's as paths, provides additional methods for Windows paths, and
    handles UNC paths on Windows properly. See the README file for more
    details.
  EOF
end
