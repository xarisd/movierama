require 'rails_helper'
require 'capybara/rails'
require 'support/pages/movie_list'
require 'support/pages/movie_new'
require 'support/with_user'

RSpec.describe 'vote on movies', type: :feature do

  let(:page) { Pages::MovieList.new }

  before do
    @author = User.create(
      uid:  'null|12345',
      name: 'Bob',
      email: 'bob@example.com',
      notify_for_like: true,
    )
    Movie.create(
      title:        'Empire strikes back',
      description:  'Who\'s scruffy-looking?',
      date:         '1980-05-21',
      user:         author
    )
  end
  let(:author) { @author }

  context 'when logged out' do
    it 'cannot vote' do
      page.open
      expect {
        page.like('Empire strikes back')
      }.to raise_error(Capybara::ElementNotFound)
    end
  end

  context 'when logged in' do
    with_logged_in_user

    before {
      ActionMailer::Base.deliveries = []
      page.open
      expect(ActionMailer::Base.deliveries).to be_empty
    }

    context 'can like' do

      it 'and send emails' do
        # 1. Like the page as 'John'
        page.like('Empire strikes back')

        # 2. Check that the page has votes
        expect(page).to have_vote_message

        # 3. Check that an email is sent
        last_email = ActionMailer::Base.deliveries.last
        expect(last_email).not_to be nil
        expect(last_email.to).to eq ['bob@example.com']
        expect(last_email.subject).to have_content 'Hey Bob'
      end

      context 'without sending emails' do
        it 'when user settings not allowing it' do
          # 0. Author has chosen NOT to get notified by email
          @author.notify_for_like = false
          @author.save

          # 1. Like the page as 'John'
          page.like('Empire strikes back')

          # 2. Check that the page has votes
          expect(page).to have_vote_message

          # 3. Check that there is no email sent at the end.
          expect(ActionMailer::Base.deliveries).to be_empty
        end
        it 'when user has not an email address' do
          # 0. Author has NOT an email address in her profile
          @author.email = nil
          @author.save

          # 1. Like the page as 'John'
          page.like('Empire strikes back')

          # 2. Check that the page has votes
          expect(page).to have_vote_message

          # 3. Check that there is no email sent at the end.
          expect(ActionMailer::Base.deliveries).to be_empty
        end
      end
    end

    it 'can hate' do
      page.hate('Empire strikes back')
      expect(page).to have_vote_message

      # Check that there is no email sent at the end. Emails are sent only for Likes!
      expect(ActionMailer::Base.deliveries).to be_empty
    end

    it 'can unlike' do
      page.like('Empire strikes back')

      # Reset the mailer after the like cause at this point an email is sent as expected.
      ActionMailer::Base.deliveries = []
      expect(ActionMailer::Base.deliveries).to be_empty

      # Try to Unlike
      page.unlike('Empire strikes back')
      expect(page).to have_unvote_message

      # Check that there is no email sent at the end. Emails are sent only for Likes!
      expect(ActionMailer::Base.deliveries).to be_empty
    end

    it 'can unhate' do
      page.hate('Empire strikes back')
      page.unhate('Empire strikes back')
      expect(page).to have_unvote_message

      # Check that there is no email sent at the end. Emails are sent only for Likes!
      expect(ActionMailer::Base.deliveries).to be_empty
    end

    it 'cannot like twice' do
      # 1. Try to like twice
      expect {
        2.times { page.like('Empire strikes back') }
      }.to raise_error(Capybara::ElementNotFound)

      # 3. Check that ONLY ONE email is sent at the end
      expect(ActionMailer::Base.deliveries.size).to eq 1
      last_email = ActionMailer::Base.deliveries.last
      expect(last_email).not_to be nil
      expect(last_email.to).to eq ['bob@example.com']
      expect(last_email.subject).to have_content 'Hey Bob'
    end

    it 'cannot like own movies' do
      # 1. Try to like
      Pages::MovieNew.new.open.submit(
        title:       'The Party',
        date:        '1969-08-13',
        description: 'Birdy nom nom')
      page.open
      expect {
        page.like('The Party')
      }.to raise_error(Capybara::ElementNotFound)

      # Check that there is no email sent at the end.
      expect(ActionMailer::Base.deliveries).to be_empty
    end
  end

end



