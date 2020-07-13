require_relative './test_init'

TestBench::Run.(
  'test/automated',
  exclude_file_pattern: %r{/_|sketch|(_init\.rb|_tests\.rb)\z}
) or exit 1
