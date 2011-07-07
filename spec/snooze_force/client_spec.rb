require 'spec_helper'

describe SnoozeForce::Client do
  
  describe "test" do
    
    it "should do something" do
      client = SnoozeForce::Client.new(:instance_url => sf_instance_url, 
                                       :token => sf_token, 
                                       :uid => sf_uid, 
                                       :refresh_token => sf_refresh_token,
                                       :client_id => sf_client_id,
                                       :client_secret => sf_client_secret)
      
      # client.refresh!
      
      res = client.get("sobjects/User/#{sf_uid}")
      puts "res: #{res.inspect}"
      
      res = client.user.me
      puts "res: #{res.inspect}"
      
      puts "res.Username: #{res.Username.inspect}"
      puts "res['Username']: #{res['Username'].inspect}"
      
      res = client.news_feed.get
      puts "res: #{res.inspect}"
      
      puts "res.status: #{res.status.inspect}"
      puts "res.code: #{res.code.inspect}"
      
      puts "client.account.class.sobject: #{client.account.class.sobject.inspect}"
      
      
      res = client.query("SELECT Id, Name FROM Account")
      puts "res: #{res.inspect}"
      
      res = client.search("FIND+{Oil}")
      puts "res: #{res.inspect}"
      
      res = client.account.post('/', {:body => {'Name' => 'Billy Bob'}})
      puts "res: #{res.inspect}"
    end
    
  end
  
end