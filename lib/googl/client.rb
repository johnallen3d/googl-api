require 'httparty'

module Googl
  API_URL     = 'https://www.googleapis.com/urlshortener/'
  API_VERSION = 'v1'

  def self.new(api_key)
    Client.new(api_key)
  end

  class Client
    include HTTParty
    
    base_uri "#{API_URL}#{API_VERSION}"
    headers 'Content-Type' => 'application/json; charset=utf-8'
      
    def initialize(api_key)
      @api_key = { :key => api_key }
    end
    
    def shorten(url)
      # when providing a hash for the body the url is being URI Encoded and causing an error
      self.class.post('/url', :query => @api_key, :body => "{ \"longUrl\" => \"#{url}\" }").parsed_response
    end
    
    def extend(url)
      self.class.get('/url', :query => { :shortUrl => url }).parsed_response
    end
    
    def analytics(url, projection = "FULL")
      self.class.get('/url', :query => { :shortUrl => url, :projection => projection }).parsed_response
    end
  end
end