class ListsController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    @lists = @user.lists.order('updated_at DESC')
    @completed = List.where('user_id = ? AND completed = ?', params[:user_id], true)
  end

  def show
    @list = List.find(params[:id])
    @user = User.find(@list.user_id)
    @items = @list.items.order('updated_at DESC')
    @completed = List.where('user_id = ? AND completed = ?', params[:user_id], true)
  end

  def new
    @user = User.find(params[:user_id])
    @list = @user.lists.new
    
    authorize_user?(@user.id)
  end
  
  def create
    @user = User.find(params[:user_id])
    @list = @user.lists.new(list_params)
    
    if authorize_user?(@user.id) && @list.save
      flash[:notice] = "list [ #{ @list.title } ] created successfully."
      redirect_to list_path(@list.id)
    else
      flash[:alert] = "Error creating list. Please try again."
      redirect_to user_lists_path
    end
  end
  
  def edit
    @list = List.find(params[:id])
    authorize_user?(@list.user_id)
  end
  
  def update
    @list = List.find(params[:id])
    @list.update_attributes(list_params)
    
    if authorize_user?(@list.user_id) && @list.save
      flash[:notice] = "List title updated successfully."
      redirect_to list_path
    else
      flash[:alert] = "Error updating list title. Please try again."
      redirect_to list_path
    end
    
  end
  
  def destroy
    @list = List.find(params[:id])
    
    if authorize_user?(@list.user_id) && @list.delete
      flash[:notice] = "List successfully removed."
    else
      flash[:alert] = "Unable to remove list. Please try again"
    end
    redirect_to list_path
    # 
  end
  
  
  private
  
  def authorize_user?(id)
    current_user.id == id
  end
  
  def list_params
    params.require(:list).permit(:title, :user_id)
  end
  
end
