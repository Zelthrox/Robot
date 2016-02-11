require_relative '../spec/spec_helper.rb'

robot = Robot.new()
puts robot
puts robot.health

robot.health = 0
robot.heal!

puts robot.health