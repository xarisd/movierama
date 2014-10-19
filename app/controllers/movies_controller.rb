class MoviesController < ApplicationController
  def index
    if params[:user_id]
      @submitter = User[params[:user_id]]
      scope = Movie.find(user_id: @submitter.id)
    else
      scope = Movie.all
    end

    @movies = case params.fetch(:by, 'likers')
    when 'likers'
      scope.sort(by: 'Movie:*->liker_count', order: 'DESC')
    when 'haters'
      scope.sort(by: 'Movie:*->hater_count', order: 'DESC')
    when 'date'
      scope.sort(by: 'Movie:*->created_at',  order: 'DESC')
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
    @movie = Movie.create(attrs)
    flash[:notice] = "Movie added"
    redirect_to root_url
  end
end
