# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'maze_solver/version'

Gem::Specification.new do |spec|
  spec.name          = "maze_solver"
  spec.version       = MazeSolver::VERSION
  spec.authors       = ["Steve Lorek"]
  spec.email         = ["steve@stevelorek.com"]

  spec.summary       = %q{Solves mazes}
  spec.description   = %q{Solves mazes using a trial-and-error third-person approach.}
  spec.homepage      = "https://github.com/slorek/maze_solver"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
end
