require 'httparty'

module Googl
  # API_URL     = 'https://www.googleapis.com/urlshortener/'
  # API_VERSION = 'v1'

  class Client
    # include HTTParty
    # 
    # base_uri "#{API_URL}#{API_VERSION}"
    # headers 'Content-Type' => 'application/json; charset=utf-8'
    #   
    # def initialize(api_key)
    #   @api_key = api_key
    # end
    # 
    # def shorten(url)
    #   # when providing a hash for the body the url is being URI Encoded and causing an error
    #   self.class.post('/url', :body => "{ \"longUrl\" => \"#{url}\" }").response.body
    # end
    # 
    # def extend(url)
    #   self.class.get('/url', :query => { :shortUrl => url }).response.body
    # end
    # 
    # def analytics(url, projection = "FULL")
    #   self.class.get('/url', :query => { :shortUrl => url, :projection => projection }).response.body
    # end
  end
end