class WelcomeController < ApplicationController
  
  # skips Devise authentication for homepage welcome#index view.
  skip_before_action :authenticate_user!
  
  def index
  end
  
end
