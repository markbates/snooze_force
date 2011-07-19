require 'spec_helper'

describe SnoozeForce::Base do
  
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
  
  describe "_describe" do
    
    it "should return the describe of the SObject" do
      client.account._describe['name'].should eql 'Account'
    end
    
  end
  
  describe "_fields" do
    
    it "should return the fields for the SObject" do
      client.account._fields.should have(44).fields
      field = client.account._fields.first
      field['name'].should eql 'Id'
    end
    
  end
  
  describe "_sobject" do
    
    it "should return the SObject information from the class" do
      client.account.class.sobject.should_not be_nil
      client.account._sobject.should eql client.account.class.sobject
    end
    
  end
  
end
