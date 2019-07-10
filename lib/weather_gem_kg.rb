# require "weather_kg/version"
require "httparty"

module ApiXu
  class TodayWeather
    @data =  HTTParty.get("http://api.apixu.com/v1/forecast.json?key=6d79fff9ef764b8c85d61836190907&q=Bishkek&days=5")
    def self.location
      @data["location"]["name"]
    end
    
    def self.temperature
      @temper = @data["current"]["temp_c"]
      @temper.to_i
    end
    
    def self.time
      @time = @data["location"]["localtime"]
      now_time = Time.parse(@time)
      now_time.ctime.slice(0, 16)
    end

    def self.condition
      @data["current"]["condition"]["text"]      
    end    
  end
  
  class FiveDayWeather
    @data =  HTTParty.get("http://api.apixu.com/v1/forecast.json?key=6d79fff9ef764b8c85d61836190907&q=Bishkek&days=5")
    def self.fiveday_weather
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
        five << one
      end
      return five
    end
  end
end

module DarkSky
  class TodayWeather
    @data = HTTParty.get("https://api.darksky.net/forecast/0a06f48b71537e4e72554c3f8d39d234/42.862,74.557")
    def self.location
      @data["timezone"]
    end
    
    def self.temperature
      farenheit = @data["currently"]["temperature"]
      celsius = (farenheit - 32) * 5/9
      celsius.to_i
    end
    
    def self.time
      time = @data["currently"]["time"]
      local_time = Time.at(time)
      local_time.ctime.to_s.slice(0, 16)
    end

    def self.condition
      @data["currently"]["summary"]    
    end  
  end

  class FiveDayWeather
    @data = HTTParty.get("https://api.darksky.net/forecast/0a06f48b71537e4e72554c3f8d39d234/42.862,74.557")
    def self.fiveday_weather
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
        five << one
      end 
      return five
    end
  end
end

ApiXu::FiveDayWeather.fiveday_weather
# puts ApiXu::TodayWeather.location
# puts ApiXu::TodayWeather.temperature
# puts ApiXu::TodayWeather.time
# puts ApiXu::TodayWeather.condition

# DarkSky::FiveDayWeather.fiveday_weather
# puts DarkSky::TodayWeather.location
# puts DarkSky::TodayWeather.temperature
# puts DarkSky::TodayWeather.time
# puts DarkSky::TodayWeather.condition
