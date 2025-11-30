require 'rake'
require 'rake/clean'
require 'rspec/core/rake_task'

CLEAN.include("**/*.gem", "**/*.rbc")

namespace :gem do
  desc "Build the pathname2 gem"
  task :create => [:clean] do
    require 'rubygems/package'
    spec = eval(IO.read('pathname2.gemspec'))
    spec.signing_key = File.join(Dir.home, '.ssh', 'gem-private_key.pem')
    Gem::Package.build(spec, true)
  end

  desc "Install the pathname2 gem"
  task :install => [:create] do
     file = Dir["*.gem"].first
     sh "gem install -l #{file}"
  end
end

namespace :spec do
  RSpec::Core::RakeTask.new(:all) do |t|
    t.pattern = ['spec/**/*_spec.rb']
  end

  RSpec::Core::RakeTask.new(:append) do |t|
    t.pattern = ['spec/append_spec.rb']
  end

  RSpec::Core::RakeTask.new(:is_absolute) do |t|
    t.pattern = ['spec/is_absolute_spec.rb']
  end

  RSpec::Core::RakeTask.new(:parent) do |t|
    t.pattern = ['spec/parent_spec.rb']
  end

  RSpec::Core::RakeTask.new(:pstrip) do |t|
    t.pattern = ['spec/pstrip_spec.rb']
  end
end

task :default => 'spec:all'

desc 'Run the Pathname benchmark suite'
task :benchmark do
  sh 'ruby -Ilib benchmarks/bench_pathname.rb'
end

desc 'Run the benchmark suite for Pathname#+ vs File.join'
task :benchmark_plus do
  sh 'ruby -Ilib benchmarks/bench_plus.rb'
end
