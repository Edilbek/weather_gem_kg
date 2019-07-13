RSpec.describe WeatherGemKg do
  it "has a version number" do
    expect(WeatherGemKg::VERSION).not_to be nil
  end
end

RSpec.describe WeatherGemKg::Clients::Apixu do
  before :all do
    @weather1 = WeatherGemKg::Generator.new('Bishkek', 1, WeatherGemKg::Clients::Apixu.new).generate_me
  end

  it "checks that the instances of classes not to be nil" do
    expect(@weather1).not_to be nil
  end

  
end
