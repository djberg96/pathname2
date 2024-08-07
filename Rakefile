require 'rake'
require 'rake/clean'
require 'rake/testtask'

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

desc 'Run the test suite for the pure Ruby version'
Rake::TestTask.new('test') do |t|
  t.warning = true
  t.verbose = true
   
  if File::ALT_SEPARATOR
    t.test_files = FileList["test/windows/*.rb"] + FileList["test/test_version.rb"]
  else
    t.test_files = FileList['test/test_pathname.rb']
  end
end

namespace :test do
  dir = File::ALT_SEPARATOR ? "windows" : "unix"
  Rake::TestTask.new(:all) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/*.rb"] + FileList["test/test_version.rb"]
  end

  Rake::TestTask.new(:append) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_append.rb"]
  end

  Rake::TestTask.new(:aref) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_aref.rb"]
  end

  Rake::TestTask.new(:ascend) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_ascend.rb"]
  end

  Rake::TestTask.new(:children) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_children.rb"]
  end

  Rake::TestTask.new(:clean) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_clean.rb"]
  end

  Rake::TestTask.new(:clean!) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_clean_bang.rb"]
  end

  Rake::TestTask.new(:constructor) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_constructor.rb"]
  end

  Rake::TestTask.new(:descend) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_descend.rb"]
  end

  Rake::TestTask.new(:drive_number) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_drive_number.rb"]
  end
 
  Rake::TestTask.new(:each) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_each.rb"]
  end

  Rake::TestTask.new(:facade) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_facade.rb"]
  end

  Rake::TestTask.new(:is_absolute) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_is_absolute.rb"]
  end
 
  Rake::TestTask.new(:is_relative) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_is_relative.rb"]
  end

  Rake::TestTask.new(:is_root) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_is_root.rb"]
  end

  Rake::TestTask.new(:is_unc) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_is_unc.rb"]
  end

  Rake::TestTask.new(:join) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_join.rb"]
  end
 
  Rake::TestTask.new(:long_path) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_long_path.rb"]
  end

  Rake::TestTask.new(:misc) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_misc.rb"]
  end

  Rake::TestTask.new(:parent) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_parent.rb"]
  end

  Rake::TestTask.new(:pstrip) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_pstrip.rb"]
  end

  Rake::TestTask.new(:pstrip!) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_pstrip_bang.rb"]
  end

  Rake::TestTask.new(:realpath) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_realpath.rb"]
  end

  Rake::TestTask.new(:relative_path_from) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_relative_path_from.rb"]
  end

  Rake::TestTask.new(:root) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_root.rb"]
  end

  Rake::TestTask.new(:short_path) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_short_path.rb"]
  end

  Rake::TestTask.new(:to_a) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_to_a.rb"]
  end

  Rake::TestTask.new(:undecorate) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_undecorate.rb"]
  end

  Rake::TestTask.new(:undecorate!) do |t|
    t.warning = true
    t.verbose = true
    t.test_files = FileList["test/#{dir}/test_undecorate_bang.rb"]
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

# Clean up afterwards
Rake::Task[:test].enhance do
  Rake::Task[:clean].invoke
end

task :default => :test
