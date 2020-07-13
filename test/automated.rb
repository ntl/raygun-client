require_relative './test_init'

TestBench::Run.(
  'test/automated',
  exclude_file_pattern: %r{/skip\.|(?:_init\.rb|\.sketch\.rb|_sketch\.rb|\.skip\.rb)\z|_integration|all\.rb}
) or exit 1
