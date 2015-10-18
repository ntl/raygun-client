require 'json'

require 'dependency'; Dependency.activate
require 'telemetry/logger'
require 'identifier/uuid'
require 'clock'
# require 'settings'; Settings.activate
require 'schema'
require 'casing'
require 'connection'
require 'http/protocol'

require 'raygun_client/client_info'
require 'raygun_client/error_data'
require 'raygun_client/error_data/serialize'
require 'raygun_client/http/client'
