require "httparty"
require "weather_gem_kg/version"
require "weather_gem_kg/generator"

module WeatherGemKg
end

# weather1 = WeatherGemKg::Generator.new('Bishkek', 1, WeatherGemKg::Apixu.new)
# puts weather1.generate_me
#
# weather2 = WeatherGemKg::Generator.new('Bishkek', 1, WeatherGemKg::DarkSky.new)
# puts weather2.generate_me
