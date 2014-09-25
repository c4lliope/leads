class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def linkedin
    user = User.from_omniauth(request.env["omniauth.auth"])

    if user.persisted?
      flash[:alert] = I18n.t('devise.omniauth_callbacks.success', kind: "LinkedIn")
      sign_in_and_redirect user, event: :authentication
    else
      redirect_to "/", alert: I18n.t("devise.omniauth_callbacks.failure")
    end
  end
end
