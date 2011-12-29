# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "failsafe/version"

Gem::Specification.new do |s|
  s.name        = "failsafe"
  s.version     = Failsafe::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alex Sharp"]
  s.email       = ["ajsharp@gmail.com"]
  s.homepage    = "https://github.com/ajsharp/failsafe"
  s.summary     = %q{Tiny little library for silently handling errors so they don't interrupt program flow.}
  s.description = %q{}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
