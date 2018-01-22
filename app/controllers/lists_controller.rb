class ListsController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    @lists = @user.lists.order(completed_at: :asc, created_at: :desc)
  end

  def show
    
    @list = List.find(params[:id])
    @user = User.find(@list.user_id)
    
    if authorize_user?(@user.id)
      @items = @list.items.order('completed, updated_at DESC')
      @completed = List.where('user_id = ? AND completed = ?', params[:user_id], true)
    else
      flash[:alert] = "You do not have access to this listing."
      redirect_to user_path(current_user)
    end
    
  end

  def new
    @user = User.find(params[:user_id])
    @list = @user.lists.new
  end
  
  def create
    
    @user = User.find(params[:user_id])
      
    if authorize_user?(@user.id)
      
      @list = @user.lists.new(list_params)
      if @list.save
          flash[:notice] = "list created successfully."
          redirect_to @list
      else
        flash[:alert] = "Error creating list. Please try again."
      end
    else
      flash[:alert] = "You are not authorized for such an action."
    end
    
  end
  
  def edit
    @list = List.find(params[:id])
    
    unless authorize_user?(@list.user_id)
      flash[:alert] = "You are not authorized to edit this title."
      redirect_to @list
    end
    
  end
  
  def update
    
    @list = List.find(params[:id])
    
    @user = @list.user
    # @lists = @user.lists.order('completed, updated_at DESC')
    
    if authorize_user?(@user.id)
    
      if params['request_type'] == 'toggle_completed'
        
          toggle_completed
          
          respond_to do |format|
            if @list.save
              format.js { render layout: false }
            end
            return
          end
          
      else
        @list.update_attributes(list_params)
      
        if @list.save
          flash[:notice] = "List title updated successfully."
        else
          flash[:alert] = "Error updating list title. Please try again."
        end
      end
    else
      flash[:alert] = "You are not authorized to update."
    end
    
    redirect_to list_path
    
  end
  
  def destroy
    
    @list = List.find(params[:id])
    
    @lists = List.where('user_id = ?', @list.user_id)
    
    if authorize_user?(@list.user_id)
      respond_to do |format|
        if @list.destroy
          format.js { render layout: false }
          format.html { flash[:notice] = "List successfully deleted." }
        else
          format.html { redirect_to @list.user, alert: "Unable to remove task. Please try agian." }
        end
      end
    else
      flash[:alert] = "You are not authorized to delete this list."
      redirect_to user_path(current_user)
    end
    
  end
  
  private
  
  def toggle_completed
    
    @list = List.find(params[:id])
    
    # toggle the attribute
    @list.completed = !@list.completed
    
    # if complete, set competed_at timestamp
    if @list.completed?
        @list.completed_at = Time.now
    else
        @list.completed_at = nil
    end
    
    #set updated_at timestamp
    @list.updated_at = Time.now
    
  end
  
  def authorize_user?(id)
    current_user.id == id
  end
  
  def list_params
    params.require(:list).permit(:title, :user_id)
  end
  
end
