# module WeatherGemKg
#   module Configuration
#     Config = Struct.new :api_key_apixu, :api_key_dark
#
#     class << self
#       attr_accessor :api_key_apixu, :api_key_dark
#     end
#
#     def self.configure(&config_block)
#       config_block.call config
#     end
#
#     def self.config
#       @config ||= Config.new
#     end
#   end
# end

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
