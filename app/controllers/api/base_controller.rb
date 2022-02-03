module API
  class BaseController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :authenticate!

    private

      def authenticate!
        return if user_signed_in?

        authenticate_with_http_token do |token, _|
          token_parts = token.split
          break false if token_parts.length != 2

          api_key_id = token_parts[0]
          secret = token_parts[1]

          api_key = APIKey.find_by(id: api_key_id)
          break false if api_key.nil?

          api_key.authenticate_secret(secret)
        end || request_http_token_authentication
      end
  end
end
