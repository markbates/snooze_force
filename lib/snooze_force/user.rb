module SnoozeForce
  module User
    
    def me
      self.get("#{self.client.uid}")
    end
    
  end
end