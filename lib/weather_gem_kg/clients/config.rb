class Key
  Config = Struct.new :api_key_apixu, :api_key_dark  # => MyGem::Config

  def self.configure(&config_block)
    config_block.call config         # => "some string"
  end                                # => :configure

  def self.config
    @config ||= Config.new  # => #<struct MyGem::Config property1=nil, property2=nil>, #<struct MyGem::Config property1=1, property2="some string">
  end                       # => :config
end                         # => :config

Key.configure do |c|         # => MyGem
  c.api_key_apixu = '6d79fff9ef764b8c85d61836190907'              # => 1
  c.api_key_dark = '0a06f48b71537e4e72554c3f8d39d234'  # => "some string"
end                            # => "some string"

Key.config  # => #<struct MyGem::Config property1=1, property2="some string">
