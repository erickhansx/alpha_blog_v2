module ApplicationHelper
  def gravatar_for(user, options = {size: 80})
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    gravatar_url = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class:"shadow rounded mx-auto d-block")
  end

  def current_user 
    #checks if @current_user already exist, if not then does the User.find(session[:user_id]) query
    #and assigns to @current_user the returned value. (it checks if session[:user_id] first)
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user 
  end
end
