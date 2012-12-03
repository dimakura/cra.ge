# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cra/version'

Gem::Specification.new do |gem|
  gem.name          = "cra.ge"
  gem.version       = CRA::VERSION
  gem.authors       = ["Dimitri Kurashvili"]
  gem.email         = ["dimitri@c12.ge"]
  gem.description   = %q{CRA services}
  gem.summary       = %q{Ruby client for C(ivil)R(egistry)A(gency) services}
  gem.homepage      = "http://github.com/dimakura/cra.ge"

  gem.files         = `git ls-files`.split($/)
  # gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.executables   << 'cra.exe'
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec', '~> 2.11'
  gem.add_runtime_dependency 'activesupport', '~> 3.2'
  gem.add_runtime_dependency 'rest-client', '~> 1.6'
  gem.add_runtime_dependency 'builder', '~> 3.1'
  gem.add_runtime_dependency 'bundler', '~> 1.2'
end
