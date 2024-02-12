require './fly_behavior'

class FlyWithWings < FlyBehavior
  def fly
    pp '飛んでいます！'
  end
end
