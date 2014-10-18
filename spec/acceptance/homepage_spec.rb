require 'rails_helper'
require 'capybara/rails'
require 'capybara/rspec'

module Pages
  class Home
    include Capybara::DSL

    def open
      visit('/')
    end

    def has_app_name?
      binding.pry
      page.has_content?('MovieRama')
    end
  end
end

RSpec.describe 'homepage', type: :feature do
  it 'shows the application name' do
    page = Pages::Home.new
    page.open
    expect(page).to have_app_name
  end
end
