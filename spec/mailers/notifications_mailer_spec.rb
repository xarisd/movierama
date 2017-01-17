require "rails_helper"

RSpec.describe NotificationsMailer, :type => :mailer do
  describe "notify_user_for_like" do
    before do
      @author = User.create(
        uid:  'null|12345',
        name: 'Bob',
        email: 'bob@example.com',
      )
      @movie = Movie.create(
        title:        'Empire strikes back',
        description:  'Who\'s scruffy-looking?',
        date:         '1980-05-21',
        user:         author
      )
      @liker = User.create(
        uid:  'null|6789',
        name: 'John',
        email: 'john@example.com',
      )

      ENV["NOTIFICATIONS_MAILER_FROM"] = "notification@movierama.com"
    end

    let(:author) { @author }
    let(:movie) { @movie }
    let(:liker) { @liker }

    let(:mail) do
      NotificationsMailer.notify_user_for_like(
        movie_id: movie.id,
        liker_id: liker.id
      )
    end

    it "renders the headers" do
      expect(mail.from).to eq(["notification@movierama.com"])
      expect(mail.to).to eq([author.email])
      expect(mail.subject).to eq("Hey #{author.name}, #{liker.name} just liked your movie!")
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi #{author.name}, #{liker.name} just liked your movie: '#{movie.title}'")
    end
  end
end
