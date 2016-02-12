class RobotAlreadyDeadError < StandardError
end

class EnemyAlreadyDeadError < StandardError
end

class OutOfRangeError < StandardError
end

class NotItemError < StandardError
end

class NonPositiveIntegerError < StandardError
end

class LocationError < StandardError
end

#class ExceptionDemo
#  class Myexception < StandardError
#  end

#  def check_exception(a)
#    begin
#      if a>=10 
#        puts "No exception raised"
#      else
#        raise Myexception, "Number must be less than 10"
#      end
#      
#      rescue Myexception => e
#        puts e.message
#
#      ensure 
#        puts "MyGod I will always run"
#    end
#  end
#end