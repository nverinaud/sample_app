module SessionsHelper

  ###
  # Sign In
  #

  # Sign In Helper method
  #
  # Store user's remember token into a cookie to manage
  # a session between requests.
  #
  # @param user a User instance (see User class)
  #
  # @return
  #     Assign the instance variable current_user which is the current logged in user
  def sign_in(user)
    if use_session?
      session[:remember_token] = user.remember_token
    else
      cookies.permanent[:remember_token] = user.remember_token
    end
    current_user = user # current_user use here is a setter method call to self.current_user=()
  end


  def signed_in?
    !current_user.nil?
  end


  ###
  # Sign Out
  #

  def sign_out
    if use_session?
      session[:remember_token] = nil
    else
      cookies.delete(:remember_token)
    end
  end

  ###
  # Managing the session
  #
  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end


  ###
  # Friendly forwarding
  #

  def redirect_back_or_to(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def store_location
    session[:return_to] = request.fullpath
  end



private

  def user_from_remember_token
    if use_session?
      remember_token = session[:remember_token]
    else
      remember_token = cookies[:remember_token]
    end
    User.find_by_remember_token(remember_token) unless remember_token.nil?
  end

  def use_session?
    Rails.env.production? # Session in production only
  end

  def clear_return_to
    session.delete(:return_to)
  end

end
