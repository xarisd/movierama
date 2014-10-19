require 'rails_helper'
require 'capybara/rails'
require 'support/pages/home'

RSpec.describe 'login/logout/signup', type: :feature do
  let(:page) { Pages::Home.new }

  # setup Omniauth stubbing
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock(
      :github,
      uid: '12345',
      info: {
        name: 'John McFoo'
      }
    )
  end

  before do
    page.open
    # configure Omniauth to know about user "john mcfoo"
  end


  it 'signs up' do
    page.sign_up
    expect(page).to have_logged_in('John McFoo')
    expect(page).to have_signup_message
  end

  it 'logs out' do
    page.sign_up
    page.logout
    expect(page).to be_logged_out
  end

  it 'logs in' do
    page.sign_up
    page.logout
    page.login
    expect(page).to have_logged_in('John McFoo')
    expect(page).to have_login_message
  end
end
