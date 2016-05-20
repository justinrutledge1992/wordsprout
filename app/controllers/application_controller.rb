class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  
  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location # Might want to use this in the future...
        flash[:danger] = "Please log in."
        redirect_to root_path
      end
    end
    
    # Confirms the user is an administrator.
    def admin_user
      unless current_user.admin?
        store_location
        flash[:danger] = "Unauthorized Resource"
        redirect_to root_path
      end
    end
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      return if current_user.admin? # All personal resources are admin accessible
      
       unless @user == current_user
        store_location
        flash[:danger] = "Unauthorized Resource"
        redirect_to root_path
       end
    end
    
end