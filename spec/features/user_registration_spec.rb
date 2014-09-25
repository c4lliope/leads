require 'spec_helper'

describe 'User registration', js: true do
  scenario 'user fails to register' do
    OmniAuth.config.mock_auth[:linkedin] = :invalid_credentials
    visit root_path

    click_link(I18n.t('sign_in'))

    expect(page).to have_content "Invalid credentials"
  end

  scenario 'user registers sucessfully' do
    response = File.read("spec/support/fixtures/linkedin_omniauth_registration_response.json")
    OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new(JSON.parse(response))
    visit root_path

    click_link(I18n.t('sign_in'))

    expect(page).to have_content I18n.t("sign_out")
  end
end
