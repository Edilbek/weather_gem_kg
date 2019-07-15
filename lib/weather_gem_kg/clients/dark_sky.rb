require "geocoder"
require_relative '../config'

module WeatherGemKg
  module Clients
    class DarkSky
      API_KEY = WeatherGemKg.configuration.api_key_dark

      def initialize
        @base_url = "https://api.darksky.net/forecast/#{API_KEY}"
      end

      def get_weather(city, days)
        @data = get_weather_info(city, days)

        @data.dig("daily", "data")[0...days].map do |f|
          {
            date: Time.at(f['time']).ctime.slice(0, 10),
            max_temp: ((f["temperatureHigh"] - 32) * 5 / 9).round(1),
            min_temp: ((f["temperatureLow"] - 32) * 5 / 9).round(1),
            condition: f["summary"]
          }
        end
      end

      def get_weather_info(city, days)
        coordinates = get_city_coordinates(city)

        HTTParty.get("#{@base_url}/#{coordinates}")
      end

      def get_city_coordinates(city)
        Geocoder.search("#{city}").first.coordinates.map(&:inspect).join(',')
      end
    end
  end
end
