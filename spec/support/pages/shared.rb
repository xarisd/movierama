require 'capybara/rspec'

module Pages
  module Login
    def sign_up
      click_on('Sign up')
    end

    def login
      click_on('Log in')
    end

    def logout
      click_on('Log out')
    end

    def has_logged_in?(username)
      has_selector?('#username') or return false
      find('#username').has_content?(username)
    end

    def logged_out?
      !has_selector?('#username')
    end

    def has_login_message?
      has_content?('Welcome back')
    end

    def has_signup_message?
      has_content?('Account created')
    end

    # Checks that the page header has proper links:
    #   - `Settings`
    #   - `Log out`
    def has_proper_links_as_logged_in?
      result = false
      result |= find("a", text: "Settings")
      result |= find("a", text: "Log out")
      result
    end

    # Checks that the page header has proper links:
    #   - `Sign up`
    #   - `Log in`
    def has_proper_links_as_logged_out?
      result = false
      result |= find("a", text: "Sign up")
      result |= find("a", text: "Log in")
      result
    end
  end
end


