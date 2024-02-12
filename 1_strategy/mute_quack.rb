require './quack_behavior'

class MuteQuack < QuackBehavior
  def quack
    pp '<<沈黙>>'
  end
end
