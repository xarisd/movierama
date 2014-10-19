class MoviesController < ApplicationController
  def index
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

  def update
  end

  def show
  end
end
