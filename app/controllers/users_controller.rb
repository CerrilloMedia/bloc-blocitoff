class UsersController < ApplicationController
  
  def show
      @user = User.find(params[:id])
      # can_access?(@user)
      @lists = List.where('user_id = ?', @user.id)
      @completed_lists = @lists.where('completed = ?', true)
      
      @items = Item.where('user_id = ?', @user.id)
      @completed_items = @items.where('completed = ?', true)
  end
  
end
