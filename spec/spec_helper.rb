require 'rubygems'
require 'rspec'

require File.join(File.dirname(__FILE__), '..', 'lib', 'snooze_force')

Rspec.configure do |config|
  
  config.before(:all) do
    
  end
  
  config.after(:all) do
    
  end
  
  config.before(:each) do
    
  end
  
  config.after(:each) do
    
  end
  
end

def sf_instance_url
  ENV['SF_INSTANCE_URL']
end

def sf_client_id
  ENV['SF_CLIENT_ID']
end

def sf_client_secret
  ENV['SF_CLIENT_SECRET']
end

def sf_uid
  ENV['SF_UID']
end

def sf_token
  ENV['SF_TOKEN']
end

def sf_refresh_token
  ENV['SF_REFRESH_TOKEN']
end
