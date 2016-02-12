require_relative 'spec_helper'
#A given robot should be able to scan its surroundings 
#(tiles immediately next to its current @position) 
#Note: You should leverage the class method implemented 
#in #18
describe Robot do

  it 'the scan should show a list of robots that are only 1 range away' do
    robot1 = Robot.new
    robot2 = Robot.new
    robot3 = Robot.new
    robot4 = Robot.new
    robot5 = Robot.new

    # move robots
    robot1.move_up
    robot2.move_left
    robot3.move_up
    robot3.move_left
    robot4.move_down
    robot4.move_down
    robot5.move_up
    robot5.move_up
    robot5.move_up
    
    expect(robot1.scan_area).to include(robot1,robot2,robot3)
  end
end