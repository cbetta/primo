# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "primo/version"

Gem::Specification.new do |s|
  s.name        = "primo"
  s.version     = Primo::VERSION
  s.authors     = ["Cristiano Betta"]
  s.email       = ["cbetta@gmail.com"]
  s.homepage    = "http://github.com/cbetta/primo"
  s.summary     = "A better, configurable, default (prime) Rails stack."
  s.description = "A better, configurable, default (prime) Rails stack."
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
