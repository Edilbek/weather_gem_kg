# frozen_string_literal: true

require "weather_gem_kg/version"
require "weather_gem_kg/errors"
require "weather_gem_kg/forecast_day"
require "weather_gem_kg/client"
require "weather_gem_kg/config"
require "weather_gem_kg/clients/open_meteo"

module WeatherGemKg
  def self.forecast(city:, days: nil, client: nil)
    raise InvalidArgumentError, "city is required" if city.nil? || city.to_s.strip.empty?

    days ||= configuration.default_days
    (client || configuration.client).forecast(city: city, days: days)
  end
end
