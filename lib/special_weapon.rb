class SpecialWeapon < Weapon
  def initialize
    super("Speical Weapon", 40, 30)
    @range = 1
  end

  def hit(enemy)
    robot_in_area = enemy.all_robots_in_range_of(self.range)
    robot_in_area.each { |robot|
      robot.health -= self.damage
    }

  end
end
