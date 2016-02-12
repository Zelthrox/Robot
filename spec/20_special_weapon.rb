require_relative 'spec_helper'
#Introduce concept of a special weapon which is like 
#a grenade but with a range of 1. However, instead of 
#being targetted at a specific robot, this weapon is a 
#one-time use weapon that damages all robots surrounding 
#it. Its damage goes straight through the shields 
#(if you implemented shields) and directly affects 
#their health by 30 points.
describe SpecialWeapon do
  it 'robot1 attack robot2 with special weapon'do
    robot1 = Robot.new
    robot2 = Robot.new
    robot3 = Robot.new

    #robots move away
    robot2.move_left
    robot3.move_right

    #robot1 attacks robot2
    bomb = SpecialWeapon.new
    battery = Battery.new
    robot1.pick_up(bomb)
    robot1.attack(robot2)
    robot1.pick_up(battery)
    robot2.pick_up(battery)
    robot3.pick_up(battery)
    
    expect(robot1.shield).to eq(50)
    expect(robot2.shield).to eq(50)
    expect(robot3.shield).to eq(50)
    
    expect(robot1.health).to eq(70)
    expect(robot2.health).to eq(70)
    expect(robot3.health).to eq(100)

  end
end