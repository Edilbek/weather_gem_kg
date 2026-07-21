# frozen_string_literal: true

module WeatherGemKg
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration) if block_given?
  end

  def self.reset_configuration!
    @configuration = Configuration.new
  end

  class Configuration
    attr_writer :client
    attr_accessor :default_days

    def initialize
      @default_days = 1
      @client = nil
    end

    def client
      @client ||= Clients::OpenMeteo.new
    end
  end
end
