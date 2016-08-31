# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nessus_console/version'

Gem::Specification.new do |spec|
  spec.name          = "nessus_console"
  spec.version       = NessusConsole::VERSION
  spec.authors       = ["Vlatko Kosturjak"]
  spec.email         = ["kost@linux.hr"]

  spec.summary       = %q{Interact with Nessus through terminal: Nessus console with help of pry}
  spec.description   = %q{This is simple Nessus console with help of pry: Interact with Nessus through terminal.}
  spec.homepage      = "https://github.com/kost/nessus_console-ruby/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency 'table_print', '>= 0'
  spec.add_runtime_dependency 'nessus_rest', '>= 0'
  spec.add_runtime_dependency 'pry', '>= 0'
end
