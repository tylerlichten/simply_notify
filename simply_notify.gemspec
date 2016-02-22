# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simply_notify/version'

Gem::Specification.new do |spec|
  spec.name          = "simply_notify"
  spec.version       = SimplyNotify::VERSION
  spec.authors       = ["Tyler Lichten"]
  spec.email         = ["tlich10@gmail.com"]

  spec.summary       = %q{Delivers email notifications to users of a course website}
  spec.description   = %q{Delivers email notifications to users of a course website}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "actionmailer", "~> 4.2.5"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "actionmailer", "~> 4.2.5"
end