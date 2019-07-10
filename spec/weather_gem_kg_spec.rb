RSpec.describe WeatherGemKg do
  it "has a version number" do
    expect(WeatherGemKg::VERSION).not_to be nil
  end
end

RSpec.describe ApiXu do
  before :all do
    @city = ApiXu::TodayWeather.new("Bishkek")  
  end

  it "instance of class not to be nil" do
    expect(@city).not_to be nil
  end

  it "data of @city be correct" do
    expect(@city.location).to eq("Bishkek")
    expect(@city.time.slice(0, 13)).to eq(Time.now.ctime.slice(0, 13))
    expect(@city.temperature).not_to be nil
    expect(@city.condition).not_to be nil
  end
end

RSpec.describe DarkSky do
  before :all do
    @city = DarkSky::TodayWeather.new("42.862,74.557")  
  end

  it "instance of class not to be nil" do
    expect(@city).not_to be nil
  end

  it "data of @city be correct" do
    # expect(@city.location).to eq("Bishkek")
    expect(@city.time.slice(0, 13)).to eq(Time.now.ctime.slice(0, 13))
    expect(@city.temperature).not_to be nil
    expect(@city.condition).not_to be nil
  end
end
