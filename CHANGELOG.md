# Changelog

All notable changes to this project are documented in this file.

## [1.0.0] — 2026-07-21

### Added

- `WeatherGemKg.forecast(city:, days:, client:)` public API
- `WeatherGemKg::ForecastDay` (`date`, `max_temp`, `min_temp`, `condition`)
- `WeatherGemKg::Client` interface and `WeatherGemKg::Clients::OpenMeteo`
- Errors: `LocationNotFoundError`, `RequestError`, `InvalidArgumentError`
- GitHub Actions CI workflow
- `.ruby-version` pinned to Ruby 4.0.6
- Rails installer updated for key-free configuration

### Changed

- Runtime dependency is `httparty` only (declared in the gemspec)
- Specs use WebMock stubs (no live HTTP in CI)
- `required_ruby_version` set to `>= 3.2`

### Removed

- Apixu and Dark Sky clients
- `WeatherGemKg::Generator` and `#generate_me`
- API key settings (`api_key_apixu`, `api_key_dark`)
- `geocoder` and `vcr` dependencies
- Travis CI configuration

## [0.32.0] — prior

Initial published line with Apixu and Dark Sky providers.
