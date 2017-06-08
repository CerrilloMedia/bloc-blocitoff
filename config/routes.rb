Rails.application.routes.draw do
  
  root 'welcome#index'
  
  devise_for :users
  
  # Since Devise has it's own Users methods we need to set the `users/:id` route to our own UsersController to display as users#show method/view
  get 'users/:id' => 'users#show', as: 'user'
  
  # redirect invalid paths to root
  # get '*path' => redirect('/')

end
