require 'forwardable'

# 飲み物の基底クラス
class Beverage
  attr_reader :size

  def initialize(size)
    @size = size
  end

  def description
    NotImplementedError
  end

  def cost
    NotImplementedError
  end
end

# トッピング用の基底クラス
class CondimentDecorator
  extend Forwardable

  delegate size: :beverage

  # @param beverage [Beverage, CondimentDecorator]
  def initialize(beverage)
    @beverage = beverage
  end

  def description
    NotImplementedError
  end

  def cost
    NotImplementedError
  end

  private

  attr_reader :beverage
end

class Espresso < Beverage
  def description
    ['エスプレッソ']
  end

  def cost
    case size
    when :s
      200
    when :m
      300
    when :l
      400
    else
      raise NotImplementedError
    end
  end
end

class HouseBlend < Beverage
  def description
    ['ハウスブレンドコーヒー']
  end

  def cost
    case size
    when :s
      100
    when :m
      200
    when :l
      300
    else
      raise NotImplementedError
    end
  end
end

class Mocha < CondimentDecorator
  def description
    beverage.description.push('モカ')
  end

  def cost
    case size
    when :s
      beverage.cost + 10
    when :m
      beverage.cost + 20
    when :l
      beverage.cost + 30
    else
      raise NotImplementedError
    end
  end
end

class Soy < CondimentDecorator
  def description
    beverage.description.push('豆乳')
  end

  def cost
    case size
    when :s
      beverage.cost + 100
    when :m
      beverage.cost + 200
    when :l
      beverage.cost + 300
    else
      raise NotImplementedError
    end
  end
end

class CondimentPrettyPrint < CondimentDecorator
  def to_s
    "#{description.join('、')} #{cost}円"
  end

  def description
    beverage.description
  end

  def cost
    beverage.cost
  end
end

beverage = Espresso.new(:l)
beverage = Mocha.new(beverage)
beverage = Mocha.new(beverage)
beverage = Soy.new(beverage)
beverage = CondimentPrettyPrint.new(beverage)
pp beverage.to_s
