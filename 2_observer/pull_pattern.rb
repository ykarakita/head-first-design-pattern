require 'observer'

class WeatherData
  include Observable

  attr_reader :temperature, :humidity, :pressure

  def measurements_changed
    changed
    notify_observers
  end

  def set_measurements(temperature, humidity, pressure)
    @temperature = temperature
    @humidity = humidity
    @pressure = pressure
    measurements_changed
  end
end

class CurrentConditionsDisplay
  def initialize(subject)
    @subject = subject
    @subject.add_observer(self, :update)
  end

  def update
    # 引数で受け取らず必要なものだけをpullする
    @temperature = subject.temperature
    @humidity = subject.humidity
    @pressure = subject.pressure
    display
  end

  def display
    pp "現在の気象状況：温度 #{temperature}度 湿度#{humidity}%"
  end

  private

  attr_reader :subject, :temperature, :humidity, :pressure
end

weather_data = WeatherData.new
CurrentConditionsDisplay.new(weather_data)
weather_data.set_measurements(20, 55, 1000)
