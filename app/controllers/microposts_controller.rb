
class MicropostsController < ApplicationController

  before_filter :signed_in_user

  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created !"
      redirect_to root_path
    else
      session[:micropost] = @micropost
      redirect_to root_path
    end
  end


  def destroy

  end

end