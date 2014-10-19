class MoviesController < ApplicationController
  def index
    @movies = case params.fetch(:by, 'likers')
    when 'likers'
      Movie.all.sort(by: 'Movie:*->liker_count', order: 'DESC')
    when 'haters'
      Movie.all.sort(by: 'Movie:*->hater_count', order: 'DESC')
    when 'date'
      Movie.all.sort(by: 'Movie:*->date', order: 'ALPHA ASC')
    end
  end

  def new
    # TODO: authorize
  end

  def create
    # TODO: authorize
    attrs = params.
      slice(:title, :description, :date).
      merge(user: current_user)
    Movie.create(attrs)
    flash[:notice] = "Movie added"
    redirect_to root_url
  end
end
