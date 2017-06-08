class UsersController < ApplicationController
  include UsersHelper
  
  def show
      @user = User.find(params[:id])
      # can_access?(@user)
  end
  
end
