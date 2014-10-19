require 'rails_helper'
require 'capybara/rails'
require 'support/pages/movie_list'
require 'support/with_user'

RSpec.describe 'submit movie', type: :feature do

  let(:page) { Pages::MovieList.new }

  context 'when logged out' do
    it 'cannot vote'
  end

  context 'when logged in' do
    with_logged_in_user

    before do
      author = User.create(
        uid:  'null|12345',
        name: 'Bob'
      )
      Movie.create(
        title:        'Empire strikes back',
        description:  'Who\'s scruffy-looking?',
        date:         '1980-05-21',
        user:         author
      )
    end

    before { page.open }

    it 'can like' do
      page.like('Empire strikes back')
      expect(page).to have_vote_message
    end

    it 'can hate' do
      page.hate('Empire strikes back')
      expect(page).to have_vote_message
    end

    it 'can unlike' do
      page.like('Empire strikes back')
      page.unlike('Empire strikes back')
      expect(page).to have_unvote_message
    end

    it 'can unhate' do
      page.hate('Empire strikes back')
      page.unhate('Empire strikes back')
      expect(page).to have_unvote_message
    end

    it 'cannot like twice' do
      expect {
        2.times { page.like('Empire strikes back') }
      }.to raise_error(Capybara::ElementNotFound)
    end

    it 'cannot like own movies'
  end

end



