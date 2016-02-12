require_relative 'spec_helper'
#Batteries are items that can be used by robot to 
#recharge its shield. Implement Battery item that 
#can be used to recharge the Robot’s shield. 
#Batteries have a weight of 25.

describe Battery do
  before :each do
    @battery = Battery.new
  end

  it "should be an item" do
    expect(@battery).to be_a(Item)
  end

  it "should be have a weight of 25" do
    expect(@battery.weight).to eq(25)
  end

  it "it should recharge the battery of the robot" do
    robot = Robot.new
    robot.shield = 0
    robot.pick_up(@battery)
    expect(robot.shield).to eq(50)
  end
end