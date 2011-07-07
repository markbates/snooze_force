require 'spec_helper'

describe SnoozeForce::User do
  
  let(:client) do
    SnoozeForce::Client.new(:instance_url => sf_instance_url, 
                            :token => sf_token, 
                            :uid => sf_uid, 
                            :refresh_token => sf_refresh_token,
                            :client_id => sf_client_id,
                            :client_secret => sf_client_secret)
  end
  
  before(:each) do
    client.rebuild_sobjects!
  end
  
  describe "me" do
    
    it "should return the current user's data" do
      client.user.me.should eql client.user.get(sf_uid)
    end
    
  end
  
end
