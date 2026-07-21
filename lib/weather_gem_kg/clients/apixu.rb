require_relative '../config'

module WeatherGemKg
  module Clients
    class Apixu
      def initialize
        api_key = WeatherGemKg.configuration.api_key_apixu
        @base_url = "http://api.apixu.com/v1/forecast.json?key=#{api_key}"
      end

      def get_weather(city, days)
        @data = get_weather_info(city, days)
        @data.dig('forecast', 'forecastday').map do |f|
          day = f.dig('day')
          {
            date: Time.at(f['date_epoch']).ctime.slice(0, 10),
            max_temp: day['maxtemp_c'],
            min_temp: day['mintemp_c'],
            condition: day.dig('condition', 'text')
          }
        end
      end

      def get_weather_info(city, days)
        HTTParty.get("#{@base_url}&q=#{city}&days=#{days}")
      end
    end
  end
end
