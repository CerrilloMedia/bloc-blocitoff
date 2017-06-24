class ItemsController < ApplicationController
  
  def create
    @list = List.find(params[:list_id])
    @item = @list.items.new(item_params)
    @item.user = User.find(@list.user_id)
    
    if authorize_user?(@list.user_id) && @item.save
      flash[:notice] = "item added."
    else
      flash[:alert] = "unable to add item. Please try again."
    end
    redirect_to @list
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    
    @item = params[:item]['request_type'] == 'toggle_completed' ? Item.find(params[:item][:id]) : Item.find(params[:id])
    
    # to properly pass in variables to the _items partial within update.js.erb
    @items = Item.where('list_id = ?', @item.list_id).order('completed, updated_at DESC')
    @user  = User.find(@item.user_id)
    
    if params[:item]['request_type'] == 'toggle_completed' && authorize_user?(@item.user_id)
      
      toggle_completed
      
      respond_to do |format|
        if @item.save
          format.js { render layout: false }
        end
      end
      
    elsif authorize_user?(@user.id)
      @item.update_attributes(item_params)
      if @item.save
        flash[:notice] = "item updated successfully."
      else
        flash[:alert] = "item updated successfully."
      end
      redirect_to list_path(@item.list_id)
    end
    
  end
  
  def destroy
    
    @item = Item.find(params[:id])
    @list = List.find(@item.list_id)
    
    @user = User.find(@list.user_id)
    @items = Item.where('list_id = ?', @item.list_id)
    
    respond_to do |format|
      
      if authorize_user?(@list.user_id) && @item.delete
        format.js
        format.html { flash[:notice] = "Task successfully deleted." }
      else
        format.html { redirect_to @list, alert: "Unable to remove task. Please try again." }
      end
    
    end
    
  end
  
  def toggle_completed
    
    @item = Item.find(params[:item][:id])
    
    # toggle the attribute
    @item.completed = !@item.completed
    
    # if complete, set competed_at timestamp
    if @item.completed?
        @item.completed_at = Time.now
    else
        @item.completed_at = nil
    end
    
    #set updated_at timestamp
    @item.updated_at = Time.now
  end
  
  def authorize_user?(id)
    current_user.id == id
  end
  
  private
  
  def item_params
    params.require(:item).permit(:body, :list_id)
  end
end
