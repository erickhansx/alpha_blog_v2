class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in? #This makes this method available to our views as well not just for the controllers

  def current_user 
    #checks if @current_user already exist, if not then does the User.find(session[:user_id]) query
    #and assigns to @current_user the returned value. (it checks if session[:user_id] first)
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user 
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end

  def require_same_user
    if current_user != @article.user
      flash[:alert] = "You can only edit or delete your own articles"
      redirect_to @article
    end
  end
end
