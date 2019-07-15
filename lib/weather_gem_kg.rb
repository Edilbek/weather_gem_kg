require "httparty"
require "weather_gem_kg/version"
require "weather_gem_kg/generator"
require "weather_gem_kg/config"

module WeatherGemKg
  extend Configuration
end

# weather1 = WeatherGemKg::Generator.new('Bishkek', 1, WeatherGemKg::Clients::Apixu.new)
# weather1.generate_me
#
# weather2 = WeatherGemKg::Generator.new('Bishkek', 1, WeatherGemKg::Clients::DarkSky.new)
# puts weather2.generate_me
