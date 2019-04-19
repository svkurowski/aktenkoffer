class ApplicationController < ActionController::Base
  http_basic_authenticate_with Rails.configuration.authentication_options

  before_action :authenticate_user!
end
