module WeatherGemKg
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||=  Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end

  class Configuration
    attr_accessor :api_key_apixu, :api_key_dark

    def initialize
      @api_key_apixu = nil
      @api_key_dark = nil
    end
  end
end
