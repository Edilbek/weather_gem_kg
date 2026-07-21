# frozen_string_literal: true

require "spec_helper"

RSpec.describe WeatherGemKg::Clients::OpenMeteo do
  let(:client) { described_class.new }

  let(:geocoding_body) do
    {
      "results" => [
        {
          "name" => "Bishkek",
          "latitude" => 42.87,
          "longitude" => 74.59
        }
      ]
    }
  end

  let(:forecast_body) do
    {
      "daily" => {
        "time" => ["2026-07-21", "2026-07-22"],
        "temperature_2m_max" => [30.1, 28.4],
        "temperature_2m_min" => [15.2, 14.0],
        "weather_code" => [0, 61]
      }
    }
  end

  before do
    stub_request(:get, WeatherGemKg::Clients::OpenMeteo::GEOCODING_URL)
      .with(query: hash_including("name" => "Bishkek", "count" => "1"))
      .to_return(
        status: 200,
        body: geocoding_body.to_json,
        headers: { "Content-Type" => "application/json" }
      )

    stub_request(:get, WeatherGemKg::Clients::OpenMeteo::FORECAST_URL)
      .with(query: hash_including(
        "latitude" => "42.87",
        "longitude" => "74.59",
        "forecast_days" => "2"
      ))
      .to_return(
        status: 200,
        body: forecast_body.to_json,
        headers: { "Content-Type" => "application/json" }
      )
  end

  it "returns forecast days for a city" do
    result = client.forecast(city: "Bishkek", days: 2)

    expect(result).to eq([
      WeatherGemKg::ForecastDay.new(
        date: "2026-07-21",
        max_temp: 30.1,
        min_temp: 15.2,
        condition: "Clear sky"
      ),
      WeatherGemKg::ForecastDay.new(
        date: "2026-07-22",
        max_temp: 28.4,
        min_temp: 14.0,
        condition: "Slight rain"
      )
    ])
  end

  it "raises when the city cannot be found" do
    stub_request(:get, WeatherGemKg::Clients::OpenMeteo::GEOCODING_URL)
      .with(query: hash_including("name" => "NowhereLand"))
      .to_return(
        status: 200,
        body: { "results" => [] }.to_json,
        headers: { "Content-Type" => "application/json" }
      )

    expect {
      client.forecast(city: "NowhereLand", days: 1)
    }.to raise_error(WeatherGemKg::LocationNotFoundError)
  end

  it "raises for an invalid day count" do
    expect {
      client.forecast(city: "Bishkek", days: 0)
    }.to raise_error(WeatherGemKg::InvalidArgumentError)
  end
end
