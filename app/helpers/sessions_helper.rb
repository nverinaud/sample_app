module SessionsHelper

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
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user
  end


  def signed_in?
    !current_user.nil?
  end


  def current_user=(user)
    @current_user = user
  end


  def current_user
    @current_user ||= user_from_remember_token
  end


  private

    def user_from_remember_token
      remember_token = cookies[:remember_token]
      User.find_by_remember_token(remember_token) unless remember_token.nil?
    end

end
