# frozen_string_literal: true

module WeatherGemKg
  # Base contract for weather providers.
  # Implementations must return an Array of ForecastDay.
  class Client
    def forecast(city:, days:)
      raise NotImplementedError, "#{self.class}#forecast must be implemented"
    end
  end
end
