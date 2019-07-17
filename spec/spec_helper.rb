require "bundler/setup"
require "weather_gem_kg"
require 'webmock/rspec'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  WeatherGemKg.configure do |config|
    config.api_key_apixu = '6d79fff9ef764b8c85d61836190907'
    config.api_key_dark = '0a06f48b71537e4e72554c3f8d39d234'
  end

  WebMock.disable_net_connect!(allow_localhost: true)
end
