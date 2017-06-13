class ListsController < ApplicationController
  before_action :authorize_user, except: [:index, :show]
  
  def index
    @user = User.find(params[:user_id])
    @lists = @user.lists.order('updated_at DESC')
  end

  def show
    @list = params[:id]
    @completed = List.where('user_id = ? AND completed = ?', params[:user_id], true)
  end

  def new
    @user = User.find(params[:user_id])
    # @list = List.new
    @list = @user.lists.new
  end
  
  def create
    @user = User.find(params[:user_id])
    @list = @user.lists.new(list_params)
    
    
    if @list.save
      flash[:notice] = "list [ #{ @list.title } ] created successfully."
    else
      flash[:alert] = "Error creating list. Please try again."
    end
    redirect_to user_lists_path
  end
  
  def edit
    @list = List.find(params[:id])
  end
  
  def update
    @list = List.find(params[:id])
    @list.update_attributes(list_params)
    
    if @list.save
      flash[:notice] = "List title updated successfully."
      redirect_to user_lists_path
    else
      flash[:alert] = "Error updating list title. Please try again."
      render :edit
    end
    
  end
  
  def authorize_user
    @user = User.find(params[:user_id])
    unless current_user == @user
      flash[:alert] = "Permission denied."
      redirect_to :back
    end
    
  end
  
  private
  
  def list_params
    params.require(:list).permit(:title)
  end
  
end
