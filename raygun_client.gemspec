# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'ntl-raygun_client'
  s.summary = 'Client for the Raygun API'
  s.version = '0.5.0.0'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/ntl/raygun-client'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.4'

  s.add_dependency 'evt-configure'
  s.add_dependency 'evt-settings'
  s.add_dependency 'evt-telemetry'

  s.add_dependency 'ntl-error_data'

  s.add_development_dependency 'test_bench'
end
