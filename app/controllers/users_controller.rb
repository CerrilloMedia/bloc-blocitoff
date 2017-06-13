class UsersController < ApplicationController
  # include UsersHelper
  
  def show
      @user = User.find(params[:id])
      # can_access?(@user)
      # @lists = @user.lists
      @completed_lists = @user.lists.where('completed = ?', true)
  end
  
end
