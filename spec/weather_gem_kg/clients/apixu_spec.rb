RSpec.describe WeatherGemKg::Clients::Apixu do
  before :all do
    @weather_apixu = WeatherGemKg.configuration.api_key_apixu = '6d79fff9ef764b8c85d61836190907'
  end

  it "checks that the instances of classes not to be nil" do
    expect(@weather_apixu).not_to be nil
  end
end
