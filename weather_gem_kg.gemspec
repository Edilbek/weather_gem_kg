# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "weather_gem_kg/version"

Gem::Specification.new do |spec|
  spec.name          = "weather_gem_kg"
  spec.version       = WeatherGemKg::VERSION
  spec.authors       = ["Edilbek"]
  spec.email         = ["edil.talantbekov@gmail.com"]

  spec.summary       = "Daily weather forecasts via Open-Meteo"
  spec.description   = "A small Ruby gem that fetches daily city forecasts using the free Open-Meteo API."
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.2"

  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.24"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.0"
end
