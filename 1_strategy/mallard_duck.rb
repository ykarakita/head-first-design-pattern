require './duck'
require './quack'
require './fly_with_wings'

class MallardDuck < Duck
  def initialize
    @quack_behavior = Quack.new
    @fly_behavior = FlyWithWings.new
    super
  end
end
