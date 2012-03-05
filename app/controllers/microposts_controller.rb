
class MicropostsController < ApplicationController

  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

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
    @micropost.destroy
    flash[:success] = "Micropost ##{@micropost.id} destroyed !"
    redirect_back_or_to root_path
  end


private

  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_path if @micropost.nil?
  end

end