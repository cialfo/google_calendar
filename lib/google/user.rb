require "json"
module Google
  class User
    def initialize(params={}, connection=nil)
      @connection = connection || Connection.new(
          :client_id => params[:client_id],
          :client_secret => params[:client_secret],
          :redirect_url => params[:redirect_url]
      )

    end
    def access_token
      @connection.access_token
    end
    def login_with_auth_code(auth_code)
      @connection.login_with_auth_code(auth_code)
    end

    def get_user_email_id(token)
      response = @connection.get_user_info(token)
      parsed_json = JSON.parse(response.body)
      return parsed_json["email"]
    end
  end
end
