require 'observer'

class WeatherData
  include Observable

  def measurements_changed
    changed
    notify_observers(temperature, humidity, pressure)
  end

  def set_measurements(temperature, humidity, pressure)
    @temperature = temperature
    @humidity = humidity
    @pressure = pressure
    measurements_changed
  end

  private

  attr_reader :temperature, :humidity, :pressure
end

class CurrentConditionsDisplay
  def initialize(subject)
    subject.add_observer(self, :update)
  end

  def update(temperature, humidity, pressure)
    @temperature = temperature
    @humidity = humidity
    @pressure = pressure
    display
  end

  def display
    pp "現在の気象状況：温度 #{temperature}度 湿度#{humidity}%"
  end

  private

  attr_reader :temperature, :humidity, :pressure
end

weather_data = WeatherData.new
CurrentConditionsDisplay.new(weather_data)
weather_data.set_measurements(20, 55, 1000)
