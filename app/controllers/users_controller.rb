class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update]

private
  def signed_in_user
    redirect_to signin_path, notice: "Please sign in." unless signed_in?
  end

public
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
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Settings successfully updated !"
      redirect_to @user
    else
      render 'edit'
    end
  end

end
