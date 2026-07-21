# WeatherGemKg

Ruby gem for daily city weather forecasts powered by [Open-Meteo](https://open-meteo.com/) (no API key required).

## Installation

Add this line to your application's Gemfile:

```ruby
gem "weather_gem_kg"
```

And then execute:

```bash
bundle install
```

Or install it yourself:

```bash
gem install weather_gem_kg
```

### Rails

```bash
rails generate weather_gem_kg:install
```

## Usage

```ruby
require "weather_gem_kg"

days = WeatherGemKg.forecast(city: "Bishkek", days: 3)

days.each do |day|
  puts "#{day.date}: #{day.min_temp}–#{day.max_temp}°C, #{day.condition}"
end
```

Each day is a `WeatherGemKg::ForecastDay` with `date`, `max_temp`, `min_temp`, and `condition`.

### Configuration

```ruby
WeatherGemKg.configure do |config|
  config.default_days = 3
  # config.client = WeatherGemKg::Clients::OpenMeteo.new
end
```

### Custom client

Any object responding to `#forecast(city:, days:)` and returning an array of `ForecastDay` can be passed:

```ruby
WeatherGemKg.forecast(city: "Bishkek", days: 1, client: MyClient.new)
```

## Development

```bash
bundle install
bundle exec rake
```

## License

MIT
