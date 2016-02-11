require_relative 'error'

class Robot
  MAX_WEIGHT = 250

  attr_reader :position, :items
  attr_accessor :health, :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @health = 100
    @equipped_weapon = nil
  end

  def move_left
    self.position[0] -= 1
  end

  def move_right
    self.position[0] +=1
  end

  def move_up
    self.position[1] +=1
  end

  def move_down
    self.position[1] -=1
  end

  def pick_up(item)
    if have_capacity?(item.weight)
      if item.kind_of?(Weapon)
        self.equipped_weapon = item
      elsif item.kind_of?(BoxOfBolts) && self.health <= 80
        item.feed(self™)
      else
        self.items << item
      end
    end
  end

  def items_weight
    self.items.reduce(0){|sum, item| sum += item.weight}
  end

  def wound(dmg)
    if health_less_than_0?(self.health, dmg)
      self.health = 0
    else
      self.health -= dmg
    end
  end

  def heal(heal_amount)
    if full_health?(self.health, heal_amount)
      self.health = 100
    else
      self.health += heal_amount
    end
  end

  def heal!
    raise RobotAlreadyDeadError, 'Invalid Move ~ Robot is already dead!' unless self.health > 0
  end

  def attack(enemy)
    raise RobotAlreadyDeadError, 'Invalid Move ~ Robot is already dead!' unless self.health > 0    
    raise EnemyAlreadyDeadError, 'Invalid Move ~ Enemy is already dead!' unless enemy.health > 0
    if within_atk_rng?(enemy.position)
      if equipped_weapon == nil
        enemy.wound(5)
      else  
        self.equipped_weapon.hit(enemy)
        self.equipped_weapon = nil  
      end
    end
  end

  private
    def have_capacity?(new_weight)
      items_weight + new_weight <= MAX_WEIGHT
    end

    def health_less_than_0?(curr_hp, dmg)
      curr_hp - dmg <= 0
    end

    def full_health?(curr_hp, add_hp)
      curr_hp + add_hp >= 100
    end

    def within_atk_rng?(enemy_position)
      ((self.position[0] - enemy_position[0]).abs <= robot_atk_rng) && ((self.position[1] - enemy_position[1]).abs <= robot_atk_rng)
    end

    def robot_atk_rng
      (equipped_weapon.range == nil) ? 1 : equipped_weapon.range
    end
end
