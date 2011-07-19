require File.join(File.dirname(__FILE__), 'sf_env')

FakeWeb.allow_net_connect = false

def fakeweb_file(name)
  File.read(File.join(File.dirname(__FILE__), 'fakeweb', name))
end

FakeWeb.register_uri(:get, "https://na9.salesforce.com/services/data/v22.0/sobjects", :body => fakeweb_file('sobjects.json'), "content-type"=>["application/json; charset=utf-8"])

FakeWeb.register_uri(:get, "https://na9.salesforce.com/services/data/v22.0/sobjects/User/#{sf_uid}", :body => fakeweb_file('user_details.json'), "content-type"=>["application/json; charset=utf-8"])

FakeWeb.register_uri(:get, "https://na9.salesforce.com/services/data/v22.0/sobjects/NewsFeed/", :body => fakeweb_file('news_feed.json'), "content-type"=>["application/json; charset=utf-8"])

FakeWeb.register_uri(:get, "https://na9.salesforce.com/services/data/v22.0/query?q=SELECT%20Id,%20Name%20FROM%20Account", :body => fakeweb_file('query.json'), "content-type"=>["application/json; charset=utf-8"])

FakeWeb.register_uri(:get, "https://na9.salesforce.com/services/data/v22.0/search?q=FIND+%7BOil%7D", :body => fakeweb_file('search.json'), "content-type"=>["application/json; charset=utf-8"])

FakeWeb.register_uri(:post, "https://na9.salesforce.com/services/data/v22.0/sobjects/Account/", :body => fakeweb_file('account_created.json'), "content-type"=>["application/json; charset=utf-8"])

FakeWeb.register_uri(:get, "https://na9.salesforce.com/services/data/v22.0/sobjects/Account/001E000000BrAeyIAF", :body => fakeweb_file('account.json'), "content-type"=>["application/json; charset=utf-8"])

FakeWeb.register_uri(:get, "https://na9.salesforce.com/services/data/v22.0/sobjects/User/404", :body => fakeweb_file('404.json'), "content-type"=>["application/json; charset=utf-8"], :status => 404)

FakeWeb.register_uri(:post, "https://login.salesforce.com/services/oauth2/token?grant_type=refresh_token&client_id=#{sf_client_id}&client_secret=#{sf_client_secret}&refresh_token=#{sf_refresh_token}", :body => fakeweb_file('refresh.json'), "content-type"=>["application/json; charset=utf-8"])

FakeWeb.register_uri(:post, "https://login.salesforce.com/services/oauth2/token?grant_type=refresh_token&client_id=#{sf_client_id}&client_secret=#{sf_client_secret}&refresh_token=", :body => fakeweb_file('no_refresh_token.json'), "content-type"=>["application/json; charset=utf-8"], :status => 400)

FakeWeb.register_uri(:post, "https://login.salesforce.com/services/oauth2/token?grant_type=refresh_token&client_id=#{sf_client_id}&client_secret=#{sf_client_secret}&refresh_token=broken", :body => fakeweb_file('no_refresh_token.json'), "content-type"=>["application/json; charset=utf-8"], :status => 400)

FakeWeb.register_uri(:get, "https://na9.salesforce.com/services/data/v22.0/sobjects/Account/describe", :body => fakeweb_file('account_describe.json'), "content-type"=>["application/json; charset=utf-8"], :status => 200)