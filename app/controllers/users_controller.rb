class UsersController < ApplicationController

  before_filter :non_signed_in_user, only: [:new, :create]
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  # GET /users
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/:id
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/:id/edit
  def edit
    # @user created by correct_user before_filter callback
  end

  # POST /users
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  # PUT /users/:id
  def update
    # @user created by correct_user before_filter callback
    if @user.update_attributes(params[:user])
      flash[:success] = "Settings successfully updated !"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /users/:id
  def destroy
    destroyedUser = User.find(params[:id])
    destroyedUser.destroy
    flash[:success] = "User \"#{destroyedUser.name}\" killed !"
    redirect_to users_path
  end


private

  def non_signed_in_user
    if signed_in?
      redirect_to root_path, notice: "You already have an account !"
    end
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

end
