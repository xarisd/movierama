class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def authenticate!(user)
    token = SecureRandom.hex
    user.update(token: token)
    session[:token] = token
    @current_user = user
  end

  def logout!
    current_user.update(token: nil) if current_user
    session[:token] = nil
    @current_user = nil
  end

  helper_method :current_user

  def current_user
    @current_user ||= begin
      if token = session[:token]
        user = User.find(token: token).first
        UserDecorator.new(user)
      else
        nil
      end
    end
  end
end
