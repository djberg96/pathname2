require 'rspec'

RSpec.configure do |config|
  config.filter_run_excluding(:windows) if RbConfig::CONFIG['host_os'] !~ /mswin|win32|dos|mingw|cygwin/i
  config.filter_run_excluding(:unix) if RbConfig::CONFIG['host_os'] =~ /mswin|win32|dos|mingw|cygwin/i
end
