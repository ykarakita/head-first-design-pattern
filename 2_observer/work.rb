# 先に進む前に、WeatherDataクラスとその表示要素を含め、気象観測所を実装するのに必要なクラスを書き出してみましょう。
# 構成要素がどのように関連するか、どのように他の開発者が独自の表示要素を実装できるかについてもわかるような図にしてください。
# ちょっとしたヒントが必要であれば、次のページを読んでください。すでにあなたのチームメイトたちが気象観測所の設計方法について話しています。

# 自分の設計
#
# class Subject
#   def register_observer(observer); end
#   def remove_observer(observer); end
#   def notify_observers; end
# end
#
# class WeatherData < Subject
#   def get_temperature; end
#   def get_humidity; end
#   def get_pressure; end
# end
#
# class Observer
#   # @param subject [Subject]
#   def initialize(subject)
#     subject.register_observer(self)
#   end
#
#   def update; end
# end
#
# class DisplayObserver < Observer
# end

class Subject
  # @param observer [Observer]
  def register_observer(observer); end
  def remove_observer(observer); end
  def notify_observers; end
end

class Observer
  # @param subject [Subject]
  def initialize(subject)
    subject.register_observer(self)
  end

  def update(temp, humidity, pressure); end
end

class DisplayElement
  def display; end
end

class WeatherData < Subject
  def initialize
    @observers = []
    super
  end

  def register_observer(observer)
    observers.push(observer)
  end

  def remove_observer(observer)
    observers.delete(observer)
  end

  def notify_observers
    observers.each { _1.update(temperature, humidity, pressure) }
  end

  def measurements_changed
    notify_observers
  end

  def set_measurements(temperature, humidity, pressure)
    @temperature = temperature
    @humidity = humidity
    @pressure = pressure
    measurements_changed
  end

  private

  attr_reader :observers, :temperature, :humidity, :pressure
end

# JavaだとDisplayElementとObserverどちらもimplementsしているがRubyだとできないのでObserverのみ継承する
class CurrentConditionsDisplay < Observer
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
