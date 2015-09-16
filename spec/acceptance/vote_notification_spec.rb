require 'rails_helper'
require 'capybara/rails'
require 'support/pages/movie_list'
require 'support/with_user'

RSpec.describe 'user receives a mail notification', type: :feature do

	let(:page) { Pages::MovieList.new }

	 before do
    author = User.create(
      uid:  'null|12345',
      name: 'Bob',
      email: 'bob@domain.com'
    )
    Movie.create(
      title:        'Wall-E',
      description:  'Eeeeeva!',
      date:         '2008-06-27',
      user:         author
    )
  end

  context 'when a user is logged in' do
    with_logged_in_user

    before { page.open }

    it 'sends a mail notification when they like a movie' do
    	expect {
    		page.like('Wall-E')
    	}.to change{ActionMailer::Base.deliveries.size}.by(1)
    end

    it 'sends a mail notification when they hate a movie' do
    	expect {
    		page.hate('Wall-E')
    	}.to change{ActionMailer::Base.deliveries.size}.by(1)
    end

  end

end