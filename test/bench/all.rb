require_relative '../test_init'

TestBench::Runner.(
  './raygun_integration/**/*.rb',
  exclude_pattern: %r{(?:_init\.rb|\.skip\.rb|all\.rb)\z}
) or exit 1
