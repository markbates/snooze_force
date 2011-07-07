require 'rubygems'
require 'rspec'
require 'fakeweb'

require File.join(File.dirname(__FILE__), '..', 'lib', 'snooze_force')

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each {|f| require f}

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