class WeatherGem
  Config = Struct.new :api_key_apixu, :api_key_dark  # => MyGem::Config

  def self.configure(&config_block)
    config_block.call config         # => "some string"
  end                                # => :configure

  def self.config
    @config ||= Config.new  # => #<struct MyGem::Config property1=nil, property2=nil>, #<struct MyGem::Config property1=1, property2="some string">
  end                       # => :config
end                         # => :config
