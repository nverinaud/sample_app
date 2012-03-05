class StaticPagesController < ApplicationController
  
  def home
    if signed_in?
      @micropost = session[:micropost].nil? ? current_user.microposts.build : session[:micropost]
      session[:micropost] = nil
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end

end
