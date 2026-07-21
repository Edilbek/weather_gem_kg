# frozen_string_literal: true

require "bundler/setup"
require "weather_gem_kg"
require "webmock/rspec"

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before do
    WeatherGemKg.reset_configuration!
  end

  WebMock.disable_net_connect!(allow_localhost: true)
end
