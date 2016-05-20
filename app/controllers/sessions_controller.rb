class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      
      # First destroy current user's session, if one exists...
      # if logged_in?
      #   log_out current_user
      # end
      
      log_in user
      # If the "remember me" checkbox is selected, remember the user:
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = 'Login successful.'
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid email/password combination.'
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    flash[:success] = "Logged Out"
    redirect_to root_path
  end
  
end