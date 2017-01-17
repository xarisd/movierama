require 'rails_helper'
require 'capybara/rails'
require 'support/pages/settings'
require 'support/with_user'

RSpec.describe 'update settings', type: :feature do

  let(:page) { Pages::Settings.new }

  context 'when logged out' do
    xit 'fails' do
      expect { page.open }.to raise CanCan::AccessDenied
    end
  end

  context 'when logged in' do
    with_logged_in_user
    before { page.open }

    it 'succeeds' do
      # 1. At first notify_for_like should be unchecked
      check_settings_for_logged_in_user(notify_for_like: false)
      # and this is reflected in the settings page
      expect(page).to have_notify_for_like_unchecked

      # 2. Change the setting
      page.submit(
        notify_for_like: true,
      )
      # and check the page
      expect(page).to have_settings_updated_message
      # expect(page).to have_notify_for_like_checked
      # and the db state
      check_settings_for_logged_in_user(notify_for_like: true)

      # 3. Uncheck the page
      page.open.submit(
        notify_for_like: false,
      )
      # and check the page
      expect(page).to have_settings_updated_message
      expect(page).to have_notify_for_like_unchecked
      # and the db state
      check_settings_for_logged_in_user(notify_for_like: false)
    end
  end
end


