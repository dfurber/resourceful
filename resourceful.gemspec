# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "resourceful/version"

Gem::Specification.new do |s|
  s.name        = "resourceful"
  s.version     = Resourceful::VERSION
  s.authors     = ["David"]
  s.email       = ["furberd@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Application skeleton using inherited resources and views, and twitter bootstrap 1.3.}
  s.description = %q{Summary pretty much says it all right now.}

  s.rubyforge_project = "resourceful"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rails", "~> 3.2.3"
  s.add_development_dependency "sqlite3"

  s.add_dependency "inherited_resources", '1.2.2'
  s.add_dependency "simple_form"
  s.add_dependency "has_scope"
  s.add_dependency "kaminari"
  s.add_dependency "slim"
  s.add_dependency "meta_search", '>= 1.1'
  s.add_dependency "cells"

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
