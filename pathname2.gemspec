require 'rubygems'

Gem::Specification.new do |spec|
  spec.name        = 'pathname2'
  spec.version     = '1.8.4'
  spec.author      = 'Daniel J. Berger'
  spec.license     = 'Apache-2.0'
  spec.email       = 'djberg96@gmail.com'
  spec.homepage    = 'https://github.com/djberg96/pathname2'
  spec.summary     = 'An alternate implementation of the Pathname class'
  spec.files       = Dir['**/*'].reject{ |f| f.include?('git') }
  spec.cert_chain  = ['certs/djberg96_pub.pem']

  spec.add_dependency('facade', '~> 1.2')
  spec.add_development_dependency('test-unit', '~> 3.4')
  spec.add_development_dependency('rake')

  spec.metadata = {
    'homepage_uri'          => 'https://github.com/djberg96/pathname2',
    'bug_tracker_uri'       => 'https://github.com/djberg96/pathname2/issues',
    'changelog_uri'         => 'https://github.com/djberg96/pathname2/blob/main/CHANGES.md',
    'documentation_uri'     => 'https://github.com/djberg96/pathname2/wiki',
    'source_code_uri'       => 'https://github.com/djberg96/pathname2',
    'wiki_uri'              => 'https://github.com/djberg96/pathname2/wiki',
    'rubygems_mfa_required' => 'true',
    'github_repo'           => 'https://github.com/djberg96/pathname2',
    'funding_uri'           => 'https://github.com/sponsors/djberg96'
  }

  if File::ALT_SEPARATOR
    spec.add_dependency('ffi')
    spec.test_files = Dir['test/windows/*.rb', 'test/test_version.rb']
    spec.platform = Gem::Platform.new(['universal', 'mingw32'])
  else
    spec.test_files = Dir['test/test_pathname.rb', 'test/test_version.rb']
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
