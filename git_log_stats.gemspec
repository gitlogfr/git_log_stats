# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git_log_stats/version'

Gem::Specification.new do |spec|
  spec.name          = 'git_log_stats'
  spec.version       = GitLogStats::VERSION
  spec.authors       = ['Simon']
  spec.email         = ['sim.w80@gmail.com']

  spec.summary       = 'todo'
  spec.description   = 'todo'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.bindir        = 'bin'
  spec.executables   = ['gitlogstats']
  spec.require_paths = ['lib']
  spec.files = Dir.glob('{bin,lib}/**/*') + %w(LICENSE.txt README.md)

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'

end
