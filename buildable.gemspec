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
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib", "lib/tasks", "lib/buildable"]

  spec.add_runtime_dependency "fpm", "~> 1.3.3"
  spec.add_runtime_dependency "foreman", "~> 0.77.0"
  spec.add_runtime_dependency "foreman-export-initd", "~> 0.1.1"
  spec.add_runtime_dependency "configureasy", "~> 1.0.0"
end
