# frozen_string_literal: true

require "spec_helper"

RSpec.describe WeatherGemKg do
  it "has a version number" do
    expect(WeatherGemKg::VERSION).not_to be_nil
  end

  describe ".forecast" do
    let(:client) { instance_double(WeatherGemKg::Client) }
    let(:days) do
      [
        WeatherGemKg::ForecastDay.new(
          date: "2026-07-21",
          max_temp: 30.0,
          min_temp: 15.0,
          condition: "Clear sky"
        )
      ]
    end

    it "delegates to the configured client" do
      allow(client).to receive(:forecast).with(city: "Bishkek", days: 1).and_return(days)

      expect(described_class.forecast(city: "Bishkek", client: client)).to eq(days)
    end

    it "uses configuration.default_days when days is omitted" do
      WeatherGemKg.configure { |config| config.default_days = 5 }
      allow(client).to receive(:forecast).with(city: "Bishkek", days: 5).and_return(days)

      described_class.forecast(city: "Bishkek", client: client)

      expect(client).to have_received(:forecast).with(city: "Bishkek", days: 5)
    end

    it "raises when city is blank" do
      expect {
        described_class.forecast(city: "  ")
      }.to raise_error(WeatherGemKg::InvalidArgumentError)
    end
  end
end
