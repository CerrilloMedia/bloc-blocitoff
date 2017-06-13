Rails.application.routes.draw do

  devise_for :users
  
  resources :users, only: [:show], path: 'user' do
    resources :lists, only: [:index]
    post '/lists' => 'lists#create'
    
    resources :lists, except: [:index], path: 'list'
  end
  
  
  # redirect invalid paths to root
  get '*path' => redirect('/')

  root 'welcome#index'
end
