# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "x11_recorder/version"

Gem::Specification.new do |s|
  s.name        = "x11_recorder"
  s.version     = X11Recorder::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jason Gowan"]
  s.email       = ["gowanjason@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Thin wrapper around ffmpeg to record X11 displays}
  s.description = %q{Thin wrapper around ffmpeg to record X11 displays}

  s.rubyforge_project = "x11_recorder"

  s.add_dependency "childprocess", ">= 0.0.1"
  s.add_development_dependency "rspec", "~> 2.5"
  s.add_development_dependency "coveralls"
  s.add_development_dependency "rake", "~> 0.9.2"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
