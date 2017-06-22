Rails.application.routes.draw do
  
  devise_for :users
  
  resources :users, only: [:show] do
    resources :lists, shallow: true do
      resources :items, only: [:create, :edit, :update, :destroy]
    end
  end
  
  # redirect invalid paths to root
  # get '*path' => redirect('/')

  root 'welcome#index'
end
