Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get '/items', to: 'items#index'
  # post '/items', to: 'items#create'
  # resources :items, only: %i[index create]
   resources :items
end
