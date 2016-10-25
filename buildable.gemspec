# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'buildable/version'

Gem::Specification.new do |spec|
  spec.name          = "buildable"
  spec.version       = `git describe --abbrev=0`
  spec.authors       = ["Alexandre Prates"]
  spec.email         = ["ajfprates@gmail.com"]
  spec.summary       = %q{Gem para criação de pacotes deb}
  spec.description   = %q{Gem para criação de pacotes deb para distribuição de seus projetos em ambientes Debian}
  spec.license       = "MIT"
  spec.homepage      = 'https://github.com/r7com/buildable'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib", "lib/tasks", "lib/buildable"]

  spec.add_runtime_dependency "rake", '~> 0'
  spec.add_runtime_dependency 'fpm', '~> 1.3', '>= 1.3.3'
  spec.add_runtime_dependency 'foreman', '~> 0.78', '>= 0.78.0'
  spec.add_runtime_dependency 'configureasy', '~> 1.0', '>= 1.0.0'
end
