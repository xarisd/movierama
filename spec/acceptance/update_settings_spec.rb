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
      ## At first notify_for_like should be unchecked
      check_settings_for_logged_in_user(notify_for_like: false)

      expect(page).to have_notify_for_like_unchecked
    end
  end

end


