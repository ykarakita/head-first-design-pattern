require './fly_behavior'

class FlyNoWay < FlyBehavior
  def fly
    pp '飛べません'
  end
end
