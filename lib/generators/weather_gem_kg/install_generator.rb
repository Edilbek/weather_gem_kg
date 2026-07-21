# frozen_string_literal: true

module WeatherGemKg
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      desc "Creates WeatherGemKg initializer for your application"

      def copy_initializer
        template "weather_gem_kg_initializer.rb", "config/initializers/weather_gem_kg.rb"
      end
    end
  end
end
