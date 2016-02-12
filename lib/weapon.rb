class Weapon < Item
  attr_reader :damage, :range

  def initialize(name, weight, dmg)
    super(name, weight)
    @damage = dmg
  end

  def hit(robot)
    robot.wound(self.damage)
  end

end
