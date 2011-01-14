require 'google_client_login'

module GooglApi
  class ClientLogin
    class << self
      def authenticate(email, password)
        login_service = GoogleClientLogin::GoogleAuth.new(:accountType => 'HOSTED_OR_GOOGLE', 
          :service => 'urlshortener', 
          :source => 'companyName-applicationName-versionID'
        )
        login_service.authenticate(email, password)
        auth_token = login_service.auth
      end
    end
  end
end