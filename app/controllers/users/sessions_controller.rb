# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    layout false

    def new
      super
    end
  end
end
