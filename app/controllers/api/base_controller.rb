module API
  class BaseController < ActionController::API
    include ActionController::HttpAuthentication::Basic::ControllerMethods

    http_basic_authenticate_with Rails.configuration.authentication_options
  end
end
