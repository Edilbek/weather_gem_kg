require "spec_helper"

RSpec.describe WeatherGemKg::Clients::Apixu do
  let(:api_key) { WeatherGemKg.configuration.api_key_apixu }
  let(:client) { described_class.new }
  let(:response_body) do
    {
      "forecast" => {
        "forecastday" => [
          {
            "date_epoch" => 1_609_459_200,
            "day" => {
              "maxtemp_c" => 25.0,
              "mintemp_c" => 10.0,
              "condition" => { "text" => "Sunny" }
            }
          }
        ]
      }
    }
  end

  before do
    stub_request(:get, "http://api.apixu.com/v1/forecast.json")
      .with(query: hash_including("q" => "Bishkek", "days" => "1", "key" => api_key))
      .to_return(
        status: 200,
        body: response_body.to_json,
        headers: { "Content-Type" => "application/json" }
      )
  end

  it "returns forecast data for the city" do
    result = WeatherGemKg::Generator.new("Bishkek", 1, client).generate_me

    expect(result).to contain_exactly(
      hash_including(max_temp: 25.0, min_temp: 10.0, condition: "Sunny")
    )
  end
end
