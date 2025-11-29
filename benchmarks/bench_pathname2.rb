#####################################################################
# bench_pathname.rb
#
# Benchmark suite for all methods of the Pathname2 class, excluding
# the facade methods.
#
# Use the Rake tasks to run this benchmark:
#
# => rake benchmark to run the pure Ruby benchmark.
#####################################################################
require 'benchmark'
require 'pathname2'
require 'rbconfig'

if RbConfig::CONFIG['host_os'] =~ /mingw|mswin/i
   path1 = Pathname2.new("C:\\Program Files\\Windows NT")
   path2 = Pathname2.new("Accessories")
   path3 = Pathname2.new("C:\\Program Files\\..\\.\\Windows NT")
else
   path1 = Pathname2.new("/usr/local")
   path2 = Pathname2.new("bin")
   path3 = Pathname2.new("/usr/../local/./bin")
   path4 = Pathname2.new("/dev/stdin")
end

MAX = 10000

Benchmark.bm(25) do |bench|
  bench.report("Pathname2.new(path)"){
    MAX.times{ Pathname2.new("/usr/local/bin") }
  }

  bench.report("Pathname2#+(Pathname2)"){
    MAX.times{ path1 + path2 }
  }

  bench.report("Pathname2#+(String)"){
    MAX.times{ path1 + path2 }
  }

  bench.report("Pathname2#children"){
    MAX.times{ path1.children }
  }

  bench.report("Pathname2#pstrip"){
    MAX.times{ path1.pstrip }
  }

  bench.report("Pathname2#pstrip!"){
    MAX.times{ path1.pstrip! }
  }

  bench.report("Pathname2#to_a"){
    MAX.times{ path1.to_a }
  }

  bench.report("Pathname2#descend"){
    MAX.times{ path1.descend{} }
  }

  bench.report("Pathname2#ascend"){
    MAX.times{ path1.ascend{} }
  }

  bench.report("Pathname2#root"){
    MAX.times{ path1.root }
  }

  bench.report("Pathname2#root?"){
    MAX.times{ path1.root? }
  }

  bench.report("Pathname2#<=>"){
    MAX.times{ path1 <=> path2 }
  }

  bench.report("Pathname2#absolute?"){
    MAX.times{ path1.absolute? }
  }

  bench.report("Pathname2#relative?"){
    MAX.times{ path1.relative? }
  }

  bench.report("Pathname2#clean"){
    MAX.times{ path3.clean }
  }

  bench.report("Pathname2#clean!"){
    MAX.times{ path3.clean! }
  }

  # Platform specific tests
  if RbConfig::CONFIG['host_os'] =~ /mingw|mswin/i
    bench.report("Pathname2.new(file_url)"){
      MAX.times{ Pathname2.new("file:///C:/usr/local/bin") }
    }

    bench.report("Pathname2#drive_number"){
      MAX.times{ path1.drive_number }
    }

    bench.report("Pathname2#unc?"){
      MAX.times{ path1.unc? }
    }

    bench.report("Pathname2#undecorate"){
      MAX.times{ path1.undecorate }
    }

    bench.report("Pathname2#undecorate!"){
      MAX.times{ path1.undecorate! }
    }

    bench.report("Pathname2#short_path"){
      MAX.times{ path1.short_path }
    }

    bench.report("Pathname2#long_path"){
      MAX.times{ path1.long_path }
    }
  else
    bench.report("Pathname2#realpath"){
      MAX.times{ path4.realpath }
    }
  end
end
