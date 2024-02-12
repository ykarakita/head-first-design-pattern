class Duck
  attr_accessor :fly_behavior, :quack_behavior

  def perform_fly
    fly_behavior.fly
  end

  def perform_quack
    quack_behavior.quack
  end

  def swim
    pp 'すべてのカモは浮きます。おとりのカモでも！'
  end
end
