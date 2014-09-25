require "spec_helper"

describe OmniauthCallbacksController, "#linkedin" do
  context "and user does not persist" do
    it "displays an error message" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      User.stub(:from_omniauth).and_return(double(persisted?: false))

      get :linkedin

      expect(response).to redirect_to '/'
      expect(flash.alert).to eq I18n.t("devise.omniauth_callbacks.failure")
    end
  end

  context "and user persists" do
    it "creates, signs in, and redirects the user" do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user)
      User.stub(:from_omniauth).and_return(user)

      get :linkedin

      expect(response).to redirect_to '/'
      expect(flash.alert).to eq I18n.t('devise.omniauth_callbacks.success', kind: 'LinkedIn')
    end
  end
end
