# Mailer class for sending notifications
class NotificationsMailer < ActionMailer::Base
  default from: "from@example.com"

  # Sends an email message for a like on a movie.
  # The message is sent TO the movie's OWNER
  def notify_user_for_like(movie_id:, liker_id: )
    movie = Movie[movie_id]
    author = movie.user
    liker = User[liker_id]

    @author_name = author_name = author.name
    @movie_title = movie_title = movie.title
    @liker_name = liker_name = liker.name

    mail(
      from: ENV.fetch("NOTIFICATIONS_MAILER_FROM", nil) ,
      to: author.email,
      subject: "Hey #{author_name}, #{liker_name} just liked your movie!"
    )
  end
end
