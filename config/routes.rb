Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # get '/items', to: 'items#index'
  # post '/items', to: 'items#create'
  #
  # создать для выборочных
  # resources :items, only: %i[index create]
  # создать для всех известных
  #  resources :items
  # создать для всех известных плюс дополнить список
  resources :items do
    get :upvote, on: :member # использовать для конкретного единственного элемента GET /items/:id/upvote
    get :expensive, on: :collection # использовать для коллекции элементов GET /items/expensive
  end

  get '/admin/users_count', to: 'admin#users_count'
end
