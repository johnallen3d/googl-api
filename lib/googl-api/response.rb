module GooglApi
  class Response
    attr_accessor :kind, :id, :longUrl, :status, :created, :analytics, :raw

    def initialize args
      # load valuse passed in hash
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
      
      # retain the hash for further inspection
      self.raw = args
    end

    # provide helper method for short url (returned as id)
    def short_url
      self.id
    end

    # proive ruby like method for longUrl
    def long_url
      self.longUrl
    end
    
    def qr_code
      "#{short_url}.qr" unless short_url.blank?
    end
  end
end