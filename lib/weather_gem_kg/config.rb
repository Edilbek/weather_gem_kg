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
WeatherGemKg.configure do |c|         # => MyGem
  c.api_key_apixu = '6d79fff9ef764b8c85d61836190907'              # => 1
  c.api_key_dark = '0a06f48b71537e4e72554c3f8d39d234'  # => "some string"
end                            # => "some string"
