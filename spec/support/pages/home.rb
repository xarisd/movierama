require 'capybara/rspec'
require 'support/pages/shared'

module Pages
  class Home
    include Capybara::DSL
    include Pages::Login

    def open
      visit('/')
    end

    def has_app_name?
      page.has_content?('MovieRama')
    end

    def has_movie_title? title
      page.has_content?(title)
    end
  end
end

