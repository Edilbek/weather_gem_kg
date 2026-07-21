# frozen_string_literal: true

module WeatherGemKg
  ForecastDay = Data.define(:date, :max_temp, :min_temp, :condition)
end
