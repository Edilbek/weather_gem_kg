RSpec.describe WeatherGemKg::Clients::DarkSky do
  before :all do
    @weather_dark = WeatherGemKg.configuration.api_key_dark = '0a06f48b71537e4e72554c3f8d39d234'
  end

  it "checks that the instances of classes not to be nil" do
    expect(@weather_dark).not_to be nil
  end
end
