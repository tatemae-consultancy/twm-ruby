# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twm-ruby/version'

Gem::Specification.new do |gem|
  gem.name          = "twm-ruby"
  gem.version       = TWM::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ["Brian Getting"]
  gem.email         = ["brian@tatem.ae"]
  gem.homepage      = "https://github.com/tatemae-consultancy/twm-ruby"
  gem.summary       = "Ruby wrapper for The Whale Museum API's"
  gem.description   = "A Ruby gem for interacting with The Whale Museum API's."
  
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency 'faraday', '>= 0.8.7'
  gem.add_dependency 'multi_json', '~> 1.7.3'
   
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "rake"
end
