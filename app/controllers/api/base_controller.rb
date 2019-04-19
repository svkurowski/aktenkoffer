module API
  class BaseController < ActionController::API
    include ActionController::HttpAuthentication::Basic::ControllerMethods

    before_action :authenticate_user!
  end
end
