require_relative 'spec_helper'

#The Robot class can be asked to return all robots in
#a given position (x,y). It should return an array of
#all the robots since multiple robots could potentially 
#be at position 0,0 (for example)

describe Robot do  
  it 'create 3 robotS, move 2 to the left and list the ones on the left only' do
    robot1 = Robot.new
    robot2 = Robot.new
    robot3 = Robot.new
    robot1.move_left
    robot3.move_left
    expect(Robot.all_robot_xy([-1,0])).to include(robot1,robot3)
  end
end