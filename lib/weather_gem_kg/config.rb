
module WeatherGemKg
  class Configuration
    Config = Struct.new :api_key_apixu, :api_key_dark

    def self.configure(&config_block)
      config_block.call config
    end

    def self.config
      @config ||= Config.new
    end
  end
end
WeatherGemKg::Configuration.configure do |c|
  c.api_key_apixu = '6d79fff9ef764b8c85d61836190907'
  c.api_key_dark = '0a06f48b71537e4e72554c3f8d39d234'
end
