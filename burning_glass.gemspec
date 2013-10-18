# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'burning_glass/version'

Gem::Specification.new do |spec|
  spec.name          = "burning_glass"
  spec.version       = BurningGlass::VERSION
  spec.authors       = ["IgniteMark"]
  spec.email         = ["mark@ignitewithus.com"]
  spec.description   = "Gem for connecting to the Burning Glass LensWebSrv service"
  spec.summary       = "Gem for connecting to the Burning Glass LensWebSrv service"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec|spec|features)/})
  spec.require_paths = ["lib"]


  spec.required_ruby_version = '>= 1.9.2'

  spec.add_dependency "savon", "~> 2.2.0"
  spec.add_dependency "httpclient", "~> 2.3.3"
  spec.add_dependency "nokogiri", "~> 1.5.9"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-given"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock", '< 1.10'

  spec.requirements << "Access to a Burning Glass resume parser server."


end
