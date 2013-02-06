# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "primo/version"

Gem::Specification.new do |s|
  s.name        = "primo"
  s.version     = Primo::VERSION
  s.authors     = ["Cristiano Betta"]
  s.email       = ["cbetta@gmail.com"]
  s.homepage    = "http://github.com/cbetta/primo"
  s.summary     = "A configurable default Rails stack using application templates"
  s.description = "A configurable default Rails stack using application templates"
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.files.reject! {|fn| ["Vagrantfile"].include?(fn) }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'commander'
  s.add_dependency 'inifile'
  s.add_dependency 'terminal-table'
  s.add_development_dependency "rspec"
  s.add_development_dependency "fakefs"
end
