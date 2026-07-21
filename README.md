# WeatherGemKg

Daily city weather forecasts for Ruby, powered by [Open-Meteo](https://open-meteo.com/).

- **No API key** required
- Returns structured `ForecastDay` objects (`date`, `max_temp`, `min_temp`, `condition`)
- Swappable client interface for custom providers
- Ruby **≥ 3.2**

## Installation

Add to your Gemfile:

```ruby
gem "weather_gem_kg", "~> 1.0"
```

Then:

```bash
bundle install
```

Or install directly:

```bash
gem install weather_gem_kg
```

Pin `~> 1.0` if you previously used `0.x` — **1.0.0 is a breaking release**. See [CHANGELOG.md](CHANGELOG.md).

### Rails

```bash
rails generate weather_gem_kg:install
```

This creates `config/initializers/weather_gem_kg.rb`.

## Usage

```ruby
require "weather_gem_kg"

forecast = WeatherGemKg.forecast(city: "Bishkek", days: 3)

forecast.each do |day|
  puts "#{day.date}: #{day.min_temp}–#{day.max_temp}°C, #{day.condition}"
end
# => 2026-07-21: 15.2–30.1°C, Clear sky
```

### `ForecastDay`

| Attribute   | Type    | Description              |
|-------------|---------|--------------------------|
| `date`      | String  | ISO date (`YYYY-MM-DD`)  |
| `max_temp`  | Float   | Daily high (°C)          |
| `min_temp`  | Float   | Daily low (°C)           |
| `condition` | String  | Human-readable condition |

`days` must be between **1 and 16** (Open-Meteo limit). If omitted, `configuration.default_days` is used (default: `1`).

### Configuration

```ruby
WeatherGemKg.configure do |config|
  config.default_days = 3
  # config.client = WeatherGemKg::Clients::OpenMeteo.new
end
```

No API keys are needed for the default Open-Meteo client.

### Errors

```ruby
begin
  WeatherGemKg.forecast(city: "Bishkek", days: 3)
rescue WeatherGemKg::LocationNotFoundError
  # city could not be geocoded
rescue WeatherGemKg::RequestError
  # HTTP / upstream failure
rescue WeatherGemKg::InvalidArgumentError
  # blank city or days out of range
end
```

All errors inherit from `WeatherGemKg::Error`.

### Custom client

Any object that implements `#forecast(city:, days:)` and returns an `Array` of `ForecastDay` can be used:

```ruby
class MyClient < WeatherGemKg::Client
  def forecast(city:, days:)
    # ...
  end
end

WeatherGemKg.forecast(city: "Bishkek", days: 1, client: MyClient.new)
# or
WeatherGemKg.configure { |c| c.client = MyClient.new }
```

## Development

```bash
bundle install
bundle exec rake          # run specs
bin/console               # interactive console with the gem loaded
```

Specs stub HTTP with WebMock — no network required for the test suite.

### Releasing to RubyGems

1. Bump `WeatherGemKg::VERSION` in `lib/weather_gem_kg/version.rb`
2. Update [CHANGELOG.md](CHANGELOG.md)
3. Commit all changes (the gemspec packs files via `git ls-files`)
4. Publish:

```bash
bundle exec rake release
# or
gem build weather_gem_kg.gemspec
gem push weather_gem_kg-X.Y.Z.gem
```

## License

MIT — see [LICENSE.txt](LICENSE.txt).
