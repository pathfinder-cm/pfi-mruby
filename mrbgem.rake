require_relative 'mrblib/pfi-mruby/version'

MRuby::Gem::Specification.new('pfi-mruby') do |spec|
  spec.license = 'MIT'
  spec.authors = 'Giovanni Sakti'
  spec.summary = '(P)ath(f)inder (I)nterface. A CLI for Pathfinder build using mruby.'
  spec.version = PfiMruby::VERSION
  spec.bins    = ['pfi-mruby']
  spec.add_dependency('mruby-print')
  spec.add_dependency('mruby-mtest')
end
