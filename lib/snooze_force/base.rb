module SnoozeForce
  class Base
    
    attr_accessor :client
    attr_accessor :options
    attr_accessor :base
    attr_accessor :response
    
    class << self
      attr_accessor :sobject
    end
    
    def initialize(client, options = {})
      self.client = client
      self.options = {:base => ''}.merge(options)
      self.base = self.options[:base]
    end
    
    %w{get post put delete head}.each do |verb|
      define_method(verb) do |path = '/', options = {}|
        path = File.join('sobjects', self.base, path)
        self.response = self.client.send(verb, path, self.options.merge(options))
        return self
      end
    end
    
    def [](key)
      self.response[key]
    end
    
    def method_missing(sym, *args, &block)
      if self.response 
        if self.response.has_key?(sym.to_s)
          return self.response[sym.to_s]
        elsif self.response.respond_to?(sym)
          return self.response.send(sym, *args, &block)
        end
      end
      super(sym, *args, &block)
    end
    
    def status
      self.response.code
    end
    alias code status
    
  end
end