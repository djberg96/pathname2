require 'rake'
require 'rake/clean'
require 'rspec/core/rake_task'

CLEAN.include("**/*.gem", "**/*.rbc", "**/*.lock")

namespace :gem do
  desc "Build the pathname2 gem"
  task :create => [:clean] do
    require 'rubygems/package'
    spec = Gem::Specification.load('pathname2.gemspec')
    spec.signing_key = File.join(Dir.home, '.ssh', 'gem-private_key.pem')
    Gem::Package.build(spec)
  end

  desc "Install the pathname2 gem"
  task :install => [:create] do
     file = Dir["*.gem"].first
     sh "gem install -l #{file}"
  end
end

desc 'Run the RSpec test suite'
RSpec::Core::RakeTask.new(:spec) do |t|
  if File::ALT_SEPARATOR
    t.pattern = 'spec/windows/**/*_spec.rb,spec/version_spec.rb'
  else
    t.pattern = 'spec/unix/**/*_spec.rb,spec/version_spec.rb'
  end
  t.rspec_opts = ['--color', '--format documentation']
end

task :test => :spec
task :default => :spec

desc 'Run the Pathname2 benchmark suite'
task :benchmark do
  sh 'ruby -Ilib benchmarks/bench_pathname2.rb'
end

desc 'Run the benchmark suite for Pathname2#+ vs File.join'
task :benchmark_plus do
  sh 'ruby -Ilib benchmarks/bench_plus.rb'
end

# Clean up afterwards
Rake::Task[:spec].enhance do
  Rake::Task[:clean].invoke
end
