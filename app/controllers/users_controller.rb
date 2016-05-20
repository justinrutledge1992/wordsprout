class UsersController < ApplicationController
  
  before_action :logged_in_user, only: [:index, :edit, :show, :update]
  before_action :admin_user,     only: [:index, :destroy]
  before_action :correct_user,   only: [:edit, :show, :update]

  def index
    @users = User.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      # remember_user...?
      flash[:success] = "Success! Please check your email to confirm your account."
      redirect_to root_path
    else
      render 'new'
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Deleted"
    redirect_to root_path
  end
  
  private
  
    def user_params
      params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
    end
  
end