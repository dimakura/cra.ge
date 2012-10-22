# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cra.ge/version'

Gem::Specification.new do |gem|
  gem.name          = "cra.ge"
  gem.version       = Cra.ge::VERSION
  gem.authors       = ["Dimitri Kurashvili"]
  gem.email         = ["dimitri@c12.ge"]
  gem.description   = %q{CRA services}
  gem.summary       = %q{Civil Registry Agency services}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
