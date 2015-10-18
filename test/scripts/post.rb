require_relative '../init'

include RaygunClient

client = HTTP::Client.build

error_data = Controls::ErrorData.example
