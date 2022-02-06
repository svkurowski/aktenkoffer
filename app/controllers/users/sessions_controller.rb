# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    layout false

    def destroy
      super do
        # Turbo requires redirects be :see_other (303); so override Devise default (302)
        # See https://github.com/heartcombo/devise/issues/5458
        return redirect_to after_sign_out_path_for(resource_name), status: :see_other, notice: I18n.t('devise.sessions.signed_out')
      end
    end
  end
end
