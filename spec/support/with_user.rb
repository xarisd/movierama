require 'support/pages/home'

module RspecSupportWithUser
  def with_auth_mock
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.add_mock(
        :github,
        uid: '12345',
        info: {
          name: 'John McFoo',
          email: 'john@example.com',
        }
      )
    end

    after do
      OmniAuth.config.test_mode = false
    end
  end

  def with_logged_in_user
    with_auth_mock

    before do
      Pages::Home.new.tap do |page|
        page.open
        page.login
      end
    end
  end

  # Module for adding helper methods
  module Helpers
    # Checks that there is a user in the db with the correct data
    # Used for checking the login/signup results
    def check_expectations_for_logged_in_user()
      user = User.find(uid: 'github|12345').first
      expect(user.name).to eq "John McFoo"
      expect(user.email).to eq "john@example.com"
    end

    # Checks that the logged in user has the correct settings in the db
    def check_settings_for_logged_in_user(notify_for_like: )
      user = User.find(uid: 'github|12345').first
      expect(user.notify_for_like).to eq notify_for_like
    end
  end

end

RSpec.configure do |c|
  c.extend RspecSupportWithUser
  c.include RspecSupportWithUser::Helpers
end
