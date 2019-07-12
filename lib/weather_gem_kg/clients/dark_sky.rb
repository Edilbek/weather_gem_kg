require "geocoder"

module WeatherGemKg
  module Clients
    class DarkSky
      API_KEY = '0a06f48b71537e4e72554c3f8d39d234'

      def initialize
        @base_url = "https://api.darksky.net/forecast/#{API_KEY}"
      end

      def get_weather(city, days)
        @data = get_weather_info(city, days)

        # Skip the previous day
        @data.dig("daily", "data")[1..days].map do |f|
          {
            date: f["time"],
            max_temp: f["temperatureHigh"],
            min_temp: f["temperatureLow"],
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
