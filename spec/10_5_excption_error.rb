require_relative 'spec_helper'

describe Robot do
  
  before :each do
    @robot = Robot.new
  end

  describe '#heal!' do
    it 'should prompt error when robot has 0 hp' do
      @robot.wound(100)
      expect{@robot.heal!}.to raise_error
    end
  end

end
