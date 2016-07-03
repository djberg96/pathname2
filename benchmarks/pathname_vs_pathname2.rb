#####################################################################
# pathname_vs_pathname2.rb
#
# Benchmark suite for all methods of the Pathname class, excluding
# the facade methods.
#
# Use the Rake tasks to run this benchmark:
#
# => rake benchmark to run the pure Ruby benchmark.
#####################################################################
require 'benchmark'
require 'rbconfig'

MAX = 100000

['pathname', 'pathname2'].each do |lib|
  require lib
  puts "\nLIB: #{lib}\n"

  if RbConfig::CONFIG['host_os'] =~ /mingw|mswin/i
     path1 = Pathname.new("C:\\Program Files\\Windows NT")
     path2 = Pathname.new("Accessories")
     path3 = Pathname.new("C:\\Program Files\\..\\.\\Windows NT")
  else
     path1 = Pathname.new("/usr/local")
     path2 = Pathname.new("bin")
     path3 = Pathname.new("/usr/../local/./bin")
     path4 = Pathname.new("/dev/stdin")
  end

  Benchmark.bm(25) do |bench|
    bench.report("Pathname.new(path)"){
      MAX.times{ Pathname.new("/usr/local/bin") }
    }

    bench.report("Pathname#+(Pathname)"){
      MAX.times{ path1 + path2 }
    }

    bench.report("Pathname#+(String)"){
      MAX.times{ path1 + path2 }
    }

    bench.report("Pathname#children"){
      MAX.times{ path1.children }
    }

    bench.report("Pathname#descend"){
      MAX.times{ path1.descend{} }
    }

    bench.report("Pathname#ascend"){
      MAX.times{ path1.ascend{} }
    }

    bench.report("Pathname#root?"){
      MAX.times{ path1.root? }
    }

    bench.report("Pathname#<=>"){
      MAX.times{ path1 <=> path2 }
    }

    bench.report("Pathname#absolute?"){
      MAX.times{ path1.absolute? }
    }

    bench.report("Pathname#relative?"){
      MAX.times{ path1.relative? }
    }

    bench.report("Pathname#cleanptah"){
      MAX.times{ path3.cleanpath }
    }
  end
end
