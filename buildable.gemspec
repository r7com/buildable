# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'buildable/version'

Gem::Specification.new do |spec|
  spec.name          = "buildable"
  spec.version       = Buildable::VERSION
  spec.authors       = ["Alexandre Prates"]
  spec.email         = ["ajfprates@gmail.com"]
  spec.summary       = %q{Gem para criar pacotes (debian) para deploy de projetos ruby.}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "fpm"
  spec.add_runtime_dependency "bundle"
  spec.add_runtime_dependency "foreman"
  spec.add_runtime_dependency "foreman-export-initd"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
end
