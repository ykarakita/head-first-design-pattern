require './mallard_duck'
require './fly_no_way'

mallard = MallardDuck.new
mallard.perform_fly
mallard.perform_quack

mallard.fly_behavior = FlyNoWay.new
mallard.perform_fly
