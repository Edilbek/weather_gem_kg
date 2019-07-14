module WeatherGemKg
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

WeatherGemKg.configure do |c|
  c.api_key_apixu = '6d79fff9ef764b8c85d61836190907'
  c.api_key_dark = '0a06f48b71537e4e72554c3f8d39d234'
end
