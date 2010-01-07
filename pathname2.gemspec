require 'rubygems'

Gem::Specification.new do |gem|
   gem.name        = 'pathname2'
   gem.version     = '1.6.3'
   gem.author      = 'Daniel J. Berger'
   gem.license     = 'Artistic 2.0'
   gem.email       = 'djberg96@gmail.com'
   gem.homepage    = 'http://www.rubyforge.org/projects/shards'
   gem.summary     = 'An alternate implementation of the Pathname class'
   gem.has_rdoc    = true
   gem.files       = Dir['**/*'].reject{ |f| f.include?('CVS') }

   gem.extra_rdoc_files  = ['README', 'CHANGES', 'MANIFEST']
   gem.rubyforge_project = 'shards' 

   gem.add_dependency('facade', '>= 1.0.4')
   gem.add_development_dependency('test-unit', '>= 2.0.3')
   
   if Config::CONFIG['host_os'] =~ /mswin|win32|dos|cygwin|mingw/i
      gem.test_file = 'test/test_pathname_windows.rb'
      gem.add_dependency('windows-pr', '>= 0.8.6')
      gem.platform = Gem::Platform::CURRENT
   else
      gem.test_file = 'test/test_pathname.rb'
   end
   
   gem.description = <<-EOF
      The pathname2 library provides an implementation of the Pathname
      class different from the one that ships as part of the Ruby standard
      library. It is a subclass of String, though several methods have been
      overridden to better fit a path context. In addition, it supports file
      URL's as paths, provides additional methods for Windows paths, and
      handles UNC paths on Windows properly. See the README file for more
      details.
   EOF
end
