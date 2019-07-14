require "weather_gem_kg/clients/apixu"
require "weather_gem_kg/clients/dark_sky"

module WeatherGemKg
  class Generator
    attr_reader :city, :day, :generator

    def initialize(city, day, generator)
      @city = city
      @day = day
      @generator = generator
    end

    def generate_me
      generator.get_weather(city, day)
    end
  end
end
