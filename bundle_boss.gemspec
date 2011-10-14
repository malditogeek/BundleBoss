# -*- encoding: utf-8 -*-
require File.expand_path('../lib/bundle_boss/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mauro Pompilio"]
  gem.email         = ["hackers.are.rockstars@gmail.com"]
  gem.description   = %q{BundleBoss does all the dirty Bundler work for you.}
  gem.summary       = %q{BundleBoss}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "bundle_boss"
  gem.require_paths = ["lib"]
  gem.version       = BundleBoss::VERSION

  gem.add_dependency("rb-fsevent", "~> 0.4.3.1")
  gem.add_dependency("growl_notify", "~> 0.0.3")
end
