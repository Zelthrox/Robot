require_relative 'error'

class Robot
  MAX_WEIGHT = 250
  MAX_HEALTH = 100
  MAX_SHIELD = 50
  ROBOT_BASE_DMG = 5

  attr_reader :position, :items
  attr_accessor :health, :equipped_weapon, :shield

  @@robot_list = []

  def initialize
    @position = [0,0]
    @items = []
    @health = MAX_HEALTH
    @shield = 0
    @equipped_weapon = nil
    @@robot_list << self
  end

  def self.all_robot
    @@robot_list
  end

  def self.all_robot_xy(location)
    @@robot_list.select {|robots| robots.position == location}
  end

  def scan_area
    all_robots_in_range_of(1)
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
    raise NotItemError, "Invalid Pick Up ~ Object is not an item" unless (item.kind_of?(Item) || item.kind_of?(Weapon))
    if (items_weight + item.weight) <= MAX_WEIGHT
      if item.kind_of?(Weapon)
        self.equipped_weapon = item
      elsif item.kind_of?(BoxOfBolts) && self.health <= 80
        item.feed(self)
      elsif item.kind_of?(Battery) && self.shield <= MAX_SHIELD
        self.shield = MAX_SHIELD
      else
        self.items << item
      end
    end
  end

  def items_weight
    self.items.reduce(0){|sum, item| sum += item.weight}
  end

  def wound(dmg)
    raise NonPositiveIntegerError, "Invalid Damage ~ Damage must be a positive number!" unless (dmg.is_a?(Integer) && dmg >= 0)
    self.shield -= dmg
    self.health += self.shield if self.shield < 0

    self.shield = 0  if self.shield < 0
    self.health = 0  if self.health < 0
  end

  def heal(heal_amount)
    raise NonPositiveIntegerError, "Invalid Heal Amount ~ Amount must be a positive number!" unless (heal_amount.is_a?(Integer) && heal_amount >= 0)
    if full_health?(self.health, heal_amount)
      self.health = MAX_HEALTH
    else
      self.health += heal_amount
    end
  end

  def heal!(heal_amount)
    raise NonPositiveIntegerError, "Invalid Heal Amount ~ Amount must be a positive number!" unless (heal_amount.is_a?(Integer) && heal_amount >= 0)
    raise RobotAlreadyDeadError, 'Invalid Move ~ Robot is already dead!' unless self.health > 0
    heal(heal_amount)
  end

  def attack(enemy)
    raise RobotAlreadyDeadError, 'Invalid Move ~ Robot is already dead!' unless self.health > 0    
    raise EnemyAlreadyDeadError, 'Invalid Move ~ Enemy is already dead!' unless enemy.health > 0
    if within_atk_rng?(enemy.position)
      if equipped_weapon == nil
        enemy.wound(ROBOT_BASE_DMG)
      else
        self.equipped_weapon.hit(enemy)
        self.equipped_weapon = nil  
      end    
    end
  end

  def all_robots_in_range_of (range)
    @@robot_list.select { |robots|
      (robots.position[0] - self.position[0]).abs <= range && (robots.position[1] - self.position[1]).abs <= range
    }
  end

  private
    def full_health?(curr_hp, add_hp)
      curr_hp + add_hp >= MAX_HEALTH
    end

    def within_atk_rng?(enemy_position)
      ((self.position[0] - enemy_position[0]).abs <= robot_atk_rng) && ((self.position[1] - enemy_position[1]).abs <= robot_atk_rng)
    end

    def robot_atk_rng
      (equipped_weapon == nil || equipped_weapon.range == nil) ? 1 : equipped_weapon.range
    end

end
