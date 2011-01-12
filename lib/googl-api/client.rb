require 'httparty'

module GooglApi
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
      raise ArgumentError.new("A URL to shorten is required") if url.blank?
      load_respose(self.class.post('/url', :body => "{ \"longUrl\" => \"#{url}\" }"))
      # api key not working at this time
      # load_respose(self.class.post('/url', :query => @api_key, :body => "{ \"longUrl\" => \"#{url}\" }"))
    end
    
    def expand(url)
      raise ArgumentError.new("A URL to expand is required") if url.blank?
      load_respose(self.class.get('/url', :query => { :shortUrl => url }))
      # api key not working at this time
      # load_respose(self.class.get('/url', :query => @api_key.merge({ :shortUrl => url })))
    end
    
    def analytics(url, projection = "FULL")
      raise ArgumentError.new("A URL to check analytics on is required") if url.blank?
      load_respose(self.class.get('/url', :query => { :shortUrl => url, :projection => projection }))
      # api key not working at this time
      # load_respose(self.class.get('/url', :query => @api_key.merge({ :shortUrl => url, :projection => projection })))
    end
  private
    def load_respose(resp)
      raise GooglError.new(resp.message, resp.code) if resp.code != 200
      GooglApi::Response.new(resp.parsed_response)
    end
  end
  
  class GooglError < StandardError
    attr_reader :code
    alias :msg :message
    def initialize(msg, code)
      @code = code
      super("#{msg} - '#{code}'")
    end
  end
end