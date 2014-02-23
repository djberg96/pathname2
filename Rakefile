require 'rake'
require 'rake/clean'
require 'rake/testtask'

CLEAN.include("**/*.gem", "**/*.rbc")

namespace :gem do
  desc "Build the pathname2 gem"
  task :create => [:clean] do
    spec = eval(IO.read('pathname2.gemspec'))
    Gem::Builder.new(spec).build
  end

  desc "Install the pathname2 gem"
  task :install => [:create] do
     file = Dir["*.gem"].first
     sh "gem install #{file}"
  end
end

desc 'Run the test suite for the pure Ruby version'
Rake::TestTask.new('test') do |t|
  t.warning = true
  t.verbose = true
   
  if File::ALT_SEPARATOR
    t.test_files = FileList['test/test_pathname_windows.rb']
  else
    t.test_files = FileList['test/test_pathname.rb']
  end
end

desc 'Run the Pathname benchmark suite'
task :benchmark do
  sh 'ruby -Ilib benchmarks/bench_pathname.rb'
end

desc 'Run the benchmark suite for Pathname#+ vs File.join'
task :benchmark_plus do
  sh 'ruby -Ilib benchmarks/bench_plus.rb'
end

task :default => :test
