require 'rake'
require 'rake/clean'
require 'rake/testtask'

desc 'Install pathname2 library (non-gem)'
task :install do
   cp 'lib/pathname2.rb', Config::CONFIG['sitelibdir']
end

desc 'Build the pathname2 gem'
task :gem do
  spec = eval(IO.read('pathname2.gemspec'))
  Gem::Builder.new(spec).build
end

desc "Install the pathname2 libarary as a gem"
task :install_gem => [:gem] do
   file = Dir["*.gem"].first
   sh "gem install #{file}"
end

desc 'Run the test suite for the pure Ruby version'
Rake::TestTask.new('test') do |t|
   t.warning = true
   t.verbose = true
   
   if Config::CONFIG['host_os'] =~ /mswin|win32|dos|cygwin|mingw/i
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
   sh 'ruby -Ilib benchmarks/bench_plus.rb'end
