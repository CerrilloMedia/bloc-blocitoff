class ItemsController < ApplicationController
  
  def create
    @list = List.find(params[:list_id])
    @item = @list.items.new(item_params)
    
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
    @item = Item.find(params[:id])
    @item.update_attributes(item_params)
    @list = List.find(@item.list_id)
    
    if authorize_user?(@list.user_id) && @item.save
      flash[:notice] = "item successfully updated."
    else
      flash[:alert] = "Error updating item. Please try again."
    end
    
    redirect_to @list
    
  end
  
  def destroy
    @item = Item.find(params[:id])
    @list = List.find(@item.list_id)
    
    if authorize_user?(@list.user_id) && @item.delete
      flash[:notice] = "Task successfully deleted."
    else
      flash[:alert] = "Unable to remove task. Please try again."
    end
    redirect_to @list
    
  end
  
  def authorize_user?(id)
    current_user.id == id
  end
  
  private
  
  def item_params
    params.require(:item).permit(:body, :list_id)
  end
end
