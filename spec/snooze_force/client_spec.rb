require 'spec_helper'

describe SnoozeForce::Client do
  
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
  
  describe "refresh!" do
    
    it "should use the refresh token to fix a bad access token" do
      client.token = 'broken'
      client.refresh!
      client.token.should_not eql('broken')
      client.token.should eql('abc123')
    end
    
    it "should handle a null refresh token" do
      expect {
        client.refresh_token = nil
        client.refresh!
      }.to raise_error(SnoozeForce::ResponseError)
    end
    
    it "should handle a bad refresh token" do
      expect {
        client.refresh_token = 'broken'
        client.refresh!
      }.to raise_error(SnoozeForce::ResponseError)
    end
    
  end
  
  describe "query" do
    
    it "should return query results" do
      res = client.query("SELECT Id, Name FROM Account")
      res['totalSize'].should eql 23
      res['records'].should have(23).items
      
      record = res['records'].last['attributes']
      record['type'].should eql 'Account'
      record['url'].should eql '/services/data/v22.0/sobjects/Account/001E000000BZ0Z6IAL'
    end
    
  end
  
  describe "search" do
    
    it "should return search results" do
      res = client.search("FIND+{Oil}")
      res.should have(13).items
      
      record = res.last['attributes']
      record['type'].should eql 'Account'
      record['url'].should eql '/services/data/v22.0/sobjects/Account/001E000000BZ0Z2IAL'
    end
    
  end
  
  describe "sobject" do
    
    it "should return the details of the remote sobject" do
      sobject = client.account.class.sobject
      sobject.should eql({"name" => "Account", "label" => "Account", "custom" => false, 
                          "keyPrefix" => "001", "labelPlural" => "Accounts", "layoutable" => true, 
                          "activateable" => false, "updateable" => true, "urls" => {
                              "sobject" => "/services/data/v22.0/sobjects/Account", 
                              "describe" => "/services/data/v22.0/sobjects/Account/describe", 
                              "rowTemplate" => "/services/data/v22.0/sobjects/Account/{ID}"
                            }, 
                          "searchable" => true, "createable" => true, "customSetting" => false, 
                          "deletable" => true, "deprecatedAndHidden" => false, "feedEnabled" => true, 
                          "mergeable" => true, "queryable" => true, "replicateable" => true, 
                          "retrieveable" => true, "undeletable" => true, "triggerable" => true})
    end
    
  end
  
  describe "post" do
    
    it "should post to a resource" do
      res = client.account.post('/', {:body => {'Name' => 'Billy Bob'}})
      res['success'].should be_true
      res = client.account.get(res['id'])
      res['Name'].should eql 'Billy Bob'
    end
    
  end
  
  describe "get" do
    
    it "should get a full path" do
      res = client.get("sobjects/User/#{sf_uid}")
      res['Name'].should eql 'Mark Bates'
    end
    
    it "should get from an sobject" do
      res = client.user.get(sf_uid)
      res['Name'].should eql 'Mark Bates'
    end
    
    it "should recover from an error" do
      expect {
        client.user.get('404')
      }.to raise_error(SnoozeForce::ResponseError)
    end
    
  end

end