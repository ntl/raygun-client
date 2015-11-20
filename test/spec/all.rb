require_relative '../test_init'

Runner.('./**/*.rb') do |exclude|
  exclude =~ /(?:_init\.rb|\.skip\.rb|all\.rb)\z/
end
