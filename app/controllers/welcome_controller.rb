class WelcomeController < ApplicationController
  
  # skips Devise authentication for homepage welcome#index view.
  skip_before_action :authenticate_user!, only: :index
  
  def index
  end
  
end
