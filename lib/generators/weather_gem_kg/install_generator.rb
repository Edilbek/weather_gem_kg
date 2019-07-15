module WeatherGemKg
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      desc "Creates Jem initializer for your application"

      def copy_initializer
        template "weather_gem_kg_initializer.rb", "config/initializers/weather_gem_kg.rb"

        puts "Install complete! Truly Outrageous!"
      end
    end
  end
end
