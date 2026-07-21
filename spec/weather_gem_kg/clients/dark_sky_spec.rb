require "spec_helper"

RSpec.describe WeatherGemKg::Clients::DarkSky do
  let(:api_key) { WeatherGemKg.configuration.api_key_dark }
  let(:client) { described_class.new }
  let(:coordinates) { [42.8746, 74.5698] }
  let(:response_body) do
    {
      "daily" => {
        "data" => [
          {
            "time" => 1_609_459_200,
            "temperatureHigh" => 77.0,
            "temperatureLow" => 50.0,
            "summary" => "Clear"
          }
        ]
      }
    }
  end

  before do
    result = instance_double(Geocoder::Result::Base, coordinates: coordinates)
    allow(Geocoder).to receive(:search).with("Bishkek").and_return([result])

    stub_request(:get, "https://api.darksky.net/forecast/#{api_key}/#{coordinates.map(&:inspect).join(',')}")
      .to_return(
        status: 200,
        body: response_body.to_json,
        headers: { "Content-Type" => "application/json" }
      )
  end

  it "returns forecast data for the city" do
    result = WeatherGemKg::Generator.new("Bishkek", 1, client).generate_me

    expect(result).to contain_exactly(
      hash_including(max_temp: 25.0, min_temp: 10.0, condition: "Clear")
    )
  end
end
