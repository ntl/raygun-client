# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'raygun_client'
  s.summary = 'Client for the Raygun API using the Obsidian HTTP client'
  s.version = '0.0.0'
  s.authors = ['']
  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2'

  s.add_runtime_dependency 'dependency'
  s.add_runtime_dependency 'telemetry-logger'
  s.add_runtime_dependency 'identifier-uuid'
  s.add_runtime_dependency 'clock'
  s.add_runtime_dependency 'schema'
  s.add_runtime_dependency 'casing'
  s.add_runtime_dependency 'connection'
  s.add_runtime_dependency 'controls'
  s.add_runtime_dependency 'http-protocol'

  s.add_development_dependency 'runner'
  s.add_development_dependency 'minitest', '~> 5.5.0'
  s.add_development_dependency 'minitest-spec-context', '0.0.3'
  # s.add_development_dependency 'minitest'
  # s.add_development_dependency 'minitest-spec-context'
  s.add_development_dependency 'pry'
end
