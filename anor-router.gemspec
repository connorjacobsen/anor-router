# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'anor/router/version'

Gem::Specification.new do |spec|
  spec.name          = 'anor-router'
  spec.version       = Anor::Router::VERSION
  spec.authors       = ['Connor Jacobsen']
  spec.email         = ['jacobsen.connor@gmail.com']

  spec.summary       = 'Ruby HTTP router'
  spec.homepage      = 'https://github.com/connorjacobsen/anor-router'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 11.2'
  spec.add_development_dependency 'rack-test', '~> 0.6'
  spec.add_development_dependency 'rspec', '~> 3.4'

  spec.add_dependency 'rack', '~> 1.6'
end
