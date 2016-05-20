class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :show, :edit, :update, :destroy]
  before_action :user_owns_entry,   only: [:edit, :update, :destroy]
  before_action :admin_user,     only: [:index]
  
  def index
    @entries = Entry.paginate(page: params[:page])
  end
  
  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.new(entry_params)
    @entry.user_id = current_user.id
    #****************************************** Find parent ID! ******************************************
    if @entry.save
      flash[:success] = "Entry created!"
      redirect_to @entry
    else
      render 'new'
    end
  end
  
  def show
    @entry = Entry.find(params[:id])
  end

  def edit
    #************************************* Allow only if child_entries is empty! *************************
    @entry = Entry.find(params[:id])
  end
  
  def update
    @entry = Entry.find(params[:id])
    if @entry.update_attributes(entry_params)
      flash[:success] = "Entry Updated"
      redirect_to @entry
    else
      render 'edit'
    end
  end

  def destroy
    entry.find(params[:id]).destroy
    flash[:success] = "Entry Deleted"
    redirect_to main_url
  end
  
  private
        def entry_params
            params.require(:entry).permit(:title, :content)
        end
        
        def user_owns_entry
          @entry = Entry.find(params[:id])
          return if current_user.admin? # All personal resources are admin accessible
          unless @entry.user_id == current_user.id # IDs match
            store_location
            flash[:danger] = "Unauthorized Resource"
            redirect_to root_path
          end
        end
end
