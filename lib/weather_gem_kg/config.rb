module WeatherGemKg
  module Configuration
    Config = Struct.new :api_key_apixu, :api_key_dark

    class << self
      attr_accessor :api_key_apixu, :api_key_dark
    end

    def self.configure(&config_block)
      config_block.call config
    end

    def self.config
      @config ||= Config.new
    end
  end
end
