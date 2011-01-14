require 'httparty'

module GooglApi
  API_URL     = 'https://www.googleapis.com/urlshortener/'
  API_VERSION = 'v1'

  def self.new(options = {})
    Client.new(options)
  end

  class Client
    include HTTParty
    
    base_uri "#{API_URL}#{API_VERSION}"
    headers 'Content-Type' => 'application/json; charset=utf-8'
      
    def initialize(options = {})
      # set api key if provided
      @api_key = { :key => options[:api_key] } if options.has_key?(:api_key)

      # set auth token for client login if provided
      if options[:email] && options[:password] && @token = ClientLogin.authenticate(options[:email], options[:password])
        self.class.headers.merge!("Authorization" => "GoogleLogin auth=#{@token}")
      end
    end
    
    def shorten(url)
      raise ArgumentError.new("A URL to shorten is required") if url.blank?
      load_respose(self.class.post('/url', :query => @api_key, :body => "{ \"longUrl\" => \"#{url}\" }"))
    end
    
    def expand(url)
      raise ArgumentError.new("A URL to expand is required") if url.blank?
      load_respose(self.class.get('/url', :query => @api_key.merge({ :shortUrl => url })))
    end
    
    def analytics(url, projection = "FULL")
      raise ArgumentError.new("A URL to check analytics on is required") if url.blank?
      load_respose(self.class.get('/url', :query => @api_key.merge({ :shortUrl => url, :projection => projection })))
    end

    def history
      raise ArgumentError.new("Doing a history search requires a Client Login (or eventually OAuth to be set)") unless @token
      self.class.get('/url/history')
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