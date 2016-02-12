require_relative 'spec_helper'
#Robots can start with 50 shield points. 
#When the robot is damaged it first drains the shield 
#and then starts affecting actual health.

#You will likely also have to fix previous tests that 
#will fail due to this enhancement. However, focus on 
#running spec 16 until you are done, then rerun all 
#your tests to find other failing tests and modify the 
#tests to modify their expectations.

describe Robot do
  before :each do
    @robot = Robot.new
    @robot.shield = 50
  end

  it "robot should lose all shield before losing health" do
    @robot.wound(100)
    expect(@robot.shield).to eq(0)
    expect(@robot.health).to eq(50)
  end

end
