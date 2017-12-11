# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git_log_stats/version'

Gem::Specification.new do |spec|
  spec.name          = 'git_log_stats'
  spec.version       = GitLogStats::VERSION
  spec.authors       = ['Simon']

  spec.summary       = 'todo'
  spec.description   = 'todo'
  spec.homepage      = 'https://gitlog.fr/git_log_stats'
  spec.license       = 'MIT'

  spec.bindir        = 'bin'
  spec.executables   = ['gitlogstats']
  spec.require_paths = ['lib']
  spec.files = Dir.glob('{bin,lib}/**/*') + %w(LICENSE.txt README.md)
  spec.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  spec.add_development_dependency 'bundler', '>1'
  spec.add_development_dependency 'rake', '>1'
  spec.add_development_dependency 'rspec'
  spec.add_dependency 'git'
  spec.add_dependency 'sqlite3'
  spec.add_dependency 'activerecord'

end
