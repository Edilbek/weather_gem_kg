# require "weather_kg/version"
require "httparty"
require "geocoder"

module Forecast
  class Weather
    attr_accessor :generator
    attr_reader :city, :day
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

class Apixu
  def get_weather(city, day_count)
    @data = HTTParty.get("http://api.apixu.com/v1/forecast.json?key=6d79fff9ef764b8c85d61836190907&q=#{city}&days=#{day_count}")
    weather_data = []
    if day_count >= 2
      one = []
      days = @data["forecast"]["forecastday"]
      location = @data["location"]["name"]
      days.each do |day|
        today = day["date_epoch"]
        one << Time.at(today).ctime.slice(0, 10)
        one << day["day"]["maxtemp_c"].to_i
        one << day["day"]["mintemp_c"].to_i
        one << day["day"]["condition"]["text"]
      end
      one.each_slice(4) do |i|
        weather_data << i
      end
    else
      location = @data["location"]["name"]
      temper = @data["current"]["temp_c"].to_i

      time = @data["location"]["localtime"]
      now_time = Time.parse(time).ctime.slice(0, 16)

      condition = @data["current"]["condition"]["text"]

      weather_data << location
      weather_data << temper
      weather_data << now_time
      weather_data << condition
    end
    return weather_data
  end
end

class DarkSky
  def get_weather(city, day)
    coor = Geocoder.search("#{city}")
    city_coor = coor.first.coordinates.map(&:inspect).join(',')
    @data = HTTParty.get("https://api.darksky.net/forecast/0a06f48b71537e4e72554c3f8d39d234/#{city_coor}")
    if day >= 2
      day = 'daily'
    elsif day == 1
      day = 'currently'
    end
    @data["#{day}"]
    weather_data =[]
    if day == 'currently'
      timezone = @data["timezone"]
      farenheit = @data["currently"]["temperature"]
      celsius = ((farenheit - 32) * 5/9).to_i

      time = @data["currently"]["time"]
      local_time = Time.at(time).ctime.to_s.slice(0, 16)

      condition = @data["currently"]["summary"]
      weather_data << timezone
      weather_data << celsius
      weather_data << local_time
      weather_data << condition
    else
      one = []
      location = @data["timezone"]
      days = @data["daily"]["data"]
      days.first(5).each do |day|
        high_farenheit = day["temperatureHigh"]
        low_farenheit = day["temperatureLow"]
        high_celsius = (high_farenheit - 32) * 5/9
        low_celsius = (low_farenheit - 32) * 5/9
        time = day["time"]
        date = Time.at(time).ctime

        one << date.slice(0, 10)
        one << high_celsius.to_i
        one << low_celsius.to_i
        one << day["summary"]
      end
      one.each_slice(4) do |i|
        weather_data << i
      end
    end
    return weather_data
  end
end
# weather = Forecast::Weather.new('Bishkek', 1, Apixu.new)
# puts weather.generate_me
#
# weather1 = Forecast::Weather.new('Bishkek', 1, DarkSky.new)
# puts weather1.generate_me
