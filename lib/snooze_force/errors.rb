module SnoozeForce
  class ResponseError < StandardError
    
    def initialize(code, message)
      super("#{code}: #{message}")
    end
    
  end
end