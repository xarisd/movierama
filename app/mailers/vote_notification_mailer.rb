class VoteNotificationMailer < ActionMailer::Base
  default from: "noreply@movierama.dev"

  def notification_mail(movie, voter, preference)
  	@movie, @voter, @preference = movie, voter, preference.to_s

  	mail(to: @movie.user.email, 
  		   subject: "#{@voter.name} #{@preference.pluralize} your movie!",
  		   template_name: "#{@preference}_mail")
  end
end
