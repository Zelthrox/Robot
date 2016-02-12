require_relative 'spec_helper'
#The Robot class should keep track of all robots 
#that are instantiated.
describe Robot do
  it 'create 2 robot and list them' do
    @robot1 = Robot.new
    @robot2 = Robot.new
    expect(Robot.all_robot).to include(@robot1, @robot2)
  end
end