# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'raygun_client'
  s.version = '0.1.7'
  s.summary = 'Client for the Raygun API using the Obsidian HTTP client'
  s.description = ' '

  s.authors = ['Obsidian Software, Inc']
  s.email = 'opensource@obsidianexchange.com'
  s.homepage = 'https://github.com/obsidian-btc/raygun-client'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.3'

  s.add_runtime_dependency 'error_data'
  s.add_runtime_dependency 'serialize'
  s.add_runtime_dependency 'connection'
  s.add_runtime_dependency 'controls'
  s.add_runtime_dependency 'http-protocol'

  s.add_development_dependency 'minitest'
  s.add_development_dependency 'minitest-spec-context'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'runner'
end
