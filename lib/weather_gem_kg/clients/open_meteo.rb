# frozen_string_literal: true

require "httparty"
require "weather_gem_kg/client"
require "weather_gem_kg/errors"
require "weather_gem_kg/forecast_day"

module WeatherGemKg
  module Clients
    class OpenMeteo < Client
      GEOCODING_URL = "https://geocoding-api.open-meteo.com/v1/search"
      FORECAST_URL = "https://api.open-meteo.com/v1/forecast"

      WEATHER_CODES = {
        0 => "Clear sky",
        1 => "Mainly clear",
        2 => "Partly cloudy",
        3 => "Overcast",
        45 => "Fog",
        48 => "Depositing rime fog",
        51 => "Light drizzle",
        53 => "Moderate drizzle",
        55 => "Dense drizzle",
        56 => "Light freezing drizzle",
        57 => "Dense freezing drizzle",
        61 => "Slight rain",
        63 => "Moderate rain",
        65 => "Heavy rain",
        66 => "Light freezing rain",
        67 => "Heavy freezing rain",
        71 => "Slight snow",
        73 => "Moderate snow",
        75 => "Heavy snow",
        77 => "Snow grains",
        80 => "Slight rain showers",
        81 => "Moderate rain showers",
        82 => "Violent rain showers",
        85 => "Slight snow showers",
        86 => "Heavy snow showers",
        95 => "Thunderstorm",
        96 => "Thunderstorm with slight hail",
        99 => "Thunderstorm with heavy hail"
      }.freeze

      def forecast(city:, days:)
        days = Integer(days)
        raise InvalidArgumentError, "days must be between 1 and 16" unless days.between?(1, 16)

        location = geocode(city)
        payload = fetch_forecast(location.fetch(:latitude), location.fetch(:longitude), days)
        parse_forecast(payload)
      end

      private

      def geocode(city)
        response = HTTParty.get(GEOCODING_URL, query: { name: city, count: 1 })
        raise RequestError, "Geocoding failed (HTTP #{response.code})" unless response.success?

        result = response.parsed_response&.dig("results", 0)
        raise LocationNotFoundError, "No location found for #{city.inspect}" unless result

        {
          latitude: result.fetch("latitude"),
          longitude: result.fetch("longitude")
        }
      end

      def fetch_forecast(latitude, longitude, days)
        response = HTTParty.get(
          FORECAST_URL,
          query: {
            latitude: latitude,
            longitude: longitude,
            daily: "weather_code,temperature_2m_max,temperature_2m_min",
            forecast_days: days,
            timezone: "auto"
          }
        )
        raise RequestError, "Forecast request failed (HTTP #{response.code})" unless response.success?

        response.parsed_response
      end

      def parse_forecast(payload)
        daily = payload.fetch("daily")
        times = daily.fetch("time")
        max_temps = daily.fetch("temperature_2m_max")
        min_temps = daily.fetch("temperature_2m_min")
        codes = daily.fetch("weather_code")

        times.each_index.map do |index|
          ForecastDay.new(
            date: times[index],
            max_temp: max_temps[index],
            min_temp: min_temps[index],
            condition: WEATHER_CODES.fetch(codes[index], "Unknown")
          )
        end
      end
    end
  end
end
