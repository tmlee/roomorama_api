# -*- encoding: utf-8 -*-
require File.expand_path('../lib/roomorama_api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["TM Lee"]
  gem.email         = ["tm89lee@gmail.com"]
  gem.description   = %q{Ruby wrapper to call Roomorama API V1.0 at https://roomorama.com/api. For a step by step guide on getting started with Roomorama API, refer to https://roomorama.com/api/step_by_step.}
  gem.summary       = %q{Ruby wrapper to call Roomorama API V1.0}
  gem.homepage      = "https://github.com/tmlee/roomorama_api"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "roomorama_api"
  gem.require_paths = ["lib"]
  gem.version       = RoomoramaApi::VERSION

  gem.add_dependency('faraday', '~> 0.8')
  gem.add_dependency('json', '~> 1.7.7')
  gem.add_development_dependency('fakeweb', "~> 1.3.0")
  gem.add_development_dependency('rake')

end
