# frozen_string_literal: true

module WeatherGemKg
  class Error < StandardError; end
  class LocationNotFoundError < Error; end
  class RequestError < Error; end
  class InvalidArgumentError < Error; end
end
