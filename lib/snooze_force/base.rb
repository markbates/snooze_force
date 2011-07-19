module SnoozeForce
  class Base
    
    attr_accessor :client
    attr_accessor :options
    attr_accessor :base
    
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
        self.client.send(verb, path, self.options.merge(options))
      end
    end
    
    def _describe
      unless @_describe
        @_describe = self.get('describe')
      end
      return @_describe
    end
    
    def _fields
      self._describe['fields']
    end
    
    def _sobject
      self.class.sobject
    end
    
  end
end