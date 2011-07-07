module SnoozeForce
  class Client
    include HTTParty
    
    attr_accessor :instance_url
    attr_accessor :token
    attr_accessor :uid
    attr_accessor :refresh_token
    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :options
    
    def initialize(options = {})
      self.instance_url = options[:instance_url]
      self.token = options[:token]
      self.uid = options[:uid]
      self.refresh_token = options[:refresh_token]
      self.client_id = options[:client_id]
      self.client_secret = options[:client_secret]
      self.options = {:headers => {'Content-Type' => 'application/json'}}.merge(options)
      
      if self.uid && !SnoozeForce.const_defined?("U#{self.uid}")
        self.rebuild_sobjects!
      end
      
    end
    
    def rebuild_sobjects!
      # Let's build all the available classes for this uid:
      res = self.get('sobjects')
      res['sobjects'].each do |sobject|
        name = sobject['name']
        eval <<-EOF
          module ::SnoozeForce
            module U#{self.uid}
              class #{name} < ::SnoozeForce::Base
                def initialize(client, options = {})
                  super
                  self.base = '#{name}'
                end
              end
            end
          end
          def self.#{name.underscore}
            unless @_#{name.underscore}
              @_#{name.underscore} = ::SnoozeForce::U#{self.uid}::#{name}.new(self)
            end
            return @_#{name.underscore}
          end
        EOF
        "::SnoozeForce::U#{self.uid}::#{name}".constantize.sobject = sobject
        "::SnoozeForce::U#{self.uid}::#{name}".constantize.send(:include, "::SnoozeForce::#{name}".constantize) if SnoozeForce.const_defined?(name)
      end
    end
    
    def refresh!
      response = HTTParty.post("https://login.salesforce.com/services/oauth2/token?grant_type=refresh_token&client_id=#{self.client_id}&client_secret=#{self.client_secret}&refresh_token=#{self.refresh_token}")
      raise SnoozeForce::ResponseError.new(response.code, response['error_description']) if response.code != 200
      self.token = response['access_token']
      self.instance_url = response['instance_url']
      response
    end
    
    def query(q = '', options = {})
      self.get("/query?q=#{URI.escape(q)}", options)
    end
    
    def search(q = '', options = {})
      self.get("/search?q=#{URI.escape(q)}", options)
    end
    
    %w{get post put delete head}.each do |verb|
      define_method(verb) do |path = '/', options = {}|
        spath = File.join(self.instance_url, '/services/data/v22.0', path)
        puts "#{verb.upcase} #{spath}"
        opts = self.options.merge(options)
        opts[:headers]['Authorization'] = "OAuth #{self.token}"
        opts[:body] = opts[:body].to_json if opts[:body]
        response = self.class.send(verb, spath, opts)
        if !(200..299).include?(response.code) && response.code != 401
          raise SnoozeForce::ResponseError.new(response.code, response.first['message'])
        elsif response.code == 401
          self.refresh!
          return self.send(verb, path, options)
        end
        return response
      end
    end

  end
end