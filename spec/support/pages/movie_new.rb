require 'capybara/rspec'

module Pages
  class MovieNew
    include Capybara::DSL

    def open
      visit('/movies/new')
    end

    def submit(title:, description:, date:)
      fill_in 'title',       with: title
      fill_in 'description', with: description
      fill_in 'date',        with: date
      click_on 'Add movie'
    end

    def has_movie_creation_message?
      page.has_content?('Movie added')
    end
  end
end


