# Cast or withdraw a vote on a movie
class VotingBooth
  def initialize(user, movie)
    @user  = user
    @movie = movie
  end

  def vote(like_or_hate, is_it_real: false)
    set = case like_or_hate
      when :like then @movie.likers
      when :hate then @movie.haters
      else raise
    end
    unvote # to guarantee consistency
    set.add(@user)
    _update_counts

    if is_it_real # Check that this is from Web...
      _notify_for_like if like_or_hate == :like # Notify for Like with an email
    end

    self
  end

  def unvote
    @movie.likers.delete(@user)
    @movie.haters.delete(@user)
    _update_counts
    self
  end

  private

  def _update_counts
    @movie.update(
      liker_count: @movie.likers.size,
      hater_count: @movie.haters.size)
  end

  def _notify_for_like
    # NotificationsMailer.delay(:queue => 'user_notifications').notify_user_for_like(movie_id:, liker_id:)
    NotificationsMailer.notify_user_for_like(movie_id: @movie.id, liker_id: @user.id).deliver
  end
end
