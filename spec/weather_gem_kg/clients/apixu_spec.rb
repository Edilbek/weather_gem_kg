require 'spec_helper'

RSpec.describe WeatherGemKg::Clients::Apixu do
  describe "#weather_apixu" do
    let(:response) {  WeatherGemKg::Generator.new('Bishkek', 1,
      WeatherGemKg::Clients::Apixu.new).generate_me }

    it "checks that the instances of classes not to be nil" do
      expect(response).not_to be nil
    end
    #
    # it 'returns a data about weather of apixu' do
    #   puts "#{response}"
    # end
  end
end

puts "===> #{WeatherGemKg.configuration.api_key_apixu}"
