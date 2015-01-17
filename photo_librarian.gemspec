# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'photo_librarian/version'

Gem::Specification.new do |spec|
  spec.name          = "photo_librarian"
  spec.version       = PhotoLibrarian::VERSION
  spec.authors       = ["Nick Maloney"]
  spec.email         = ["ngmaloney@gmail.com"]
  spec.summary       = %q{A simple photo manager}
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency "ruby-progressbar", "~> 1.7.1"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "pry"
end
