require 'rails_helper'

RSpec.describe VoteNotificationMailer do

	before do
		@voter = User.create(
			uid:  'null|12345',
      name: 'John',
      email: 'john@domain.com'
		)
		@alice = User.create(
      uid:  'null|67890',
      name: 'Alice',
      email: 'alice@domain.com'
    )
    @movie = Movie.create(
      title:        'Her',
      description:  'Play a melancholy song',
      date:         '2014-03-13',
      user:         @alice,
      liker_count:  1,
      hater_count:  1
    )
	end

	it 'sends a like email when a user likes the movie' do
		mail = VoteNotificationMailer.notification_mail(@movie, @voter, :like)

		expect(mail.subject).to eql("#{@voter.name} likes your movie!")
		expect(mail.to).to eql([@alice.email])
		expect(mail.from).to eql(['noreply@movierama.dev'])
		expect(mail.body.encoded).to match(@alice.name)
	end

	it 'sends a hate email when a user hates the movie' do
		mail = VoteNotificationMailer.notification_mail(@movie, @voter, :hate)

		expect(mail.subject).to eql("#{@voter.name} hates your movie!")
		expect(mail.to).to eql([@alice.email])
		expect(mail.from).to eql(['noreply@movierama.dev'])
		expect(mail.body.encoded).to match(@alice.name)
	end

end