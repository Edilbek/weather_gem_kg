# require "weather_kg/version"
require "httparty"

module ApiXu
  class TodayWeather
    def initialize(city)
      @city = city
      @data =  HTTParty.get("http://api.apixu.com/v1/forecast.json?key=6d79fff9ef764b8c85d61836190907&q=#{@city}&days=5")
    end
    def location
      @data["location"]["name"]
    end
    
    def temperature
      @temper = @data["current"]["temp_c"]
      @temper.to_i
    end
    
    def time
      @time = @data["location"]["localtime"]
      now_time = Time.parse(@time)
      now_time.ctime.slice(0, 16)
    end

    def condition
      @data["current"]["condition"]["text"]      
    end    
  end
  
  class FiveDayWeather
    def initialize(city)
      @city = city
      @data =  HTTParty.get("http://api.apixu.com/v1/forecast.json?key=6d79fff9ef764b8c85d61836190907&q=#{@city}&days=5")
    end
    def fiveday_weather
      five = []
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
        five << i
      end
      return five
    end
  end
end

module DarkSky
  class TodayWeather
    def initialize(city)
      @city = city
      @data = HTTParty.get("https://api.darksky.net/forecast/0a06f48b71537e4e72554c3f8d39d234/#{@city}")
    end
    def location
      @data["timezone"]
    end
    
    def temperature
      farenheit = @data["currently"]["temperature"]
      celsius = (farenheit - 32) * 5/9
      celsius.to_i
    end
    
    def time
      time = @data["currently"]["time"]
      local_time = Time.at(time)
      local_time.ctime.to_s.slice(0, 16)
    end

    def condition
      @data["currently"]["summary"]    
    end  
  end

  class FiveDayWeather
    def initialize(city)
      @city = city
      @data = HTTParty.get("https://api.darksky.net/forecast/0a06f48b71537e4e72554c3f8d39d234/#{@city}")
    end
  
    def fiveday_weather
      five = []
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
        five << i
      end
      return five
    end
  end
end
# var = ApiXu::TodayWeather.new("Talas")
# var.location
# var.temperature

# var = ApiXu::FiveDayWeather.new("Bishkek")
# var.fiveday_weather
# ApiXu::TodayWeather.location
# puts ApiXu::TodayWeather.location
# puts ApiXu::TodayWeather.temperature
# puts ApiXu::TodayWeather.time
# puts ApiXu::TodayWeather.condition
# puts '----'
# var = DarkSky::FiveDayWeather.new("42.87,74.6")
# var.fiveday_weather
# var.location
# var.temperature
# DarkSky::FiveDayWeather.fiveday_weather
# puts DarkSky::TodayWeather.location
# puts DarkSky::TodayWeather.temperature
# puts DarkSky::TodayWeather.time
# puts DarkSky::TodayWeather.condition
