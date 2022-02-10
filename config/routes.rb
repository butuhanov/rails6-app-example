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

  # root to: 'items#index'
  # http://localhost:3000/items

  # Обрабатываем марщруты
  # get '/questions/new', to: 'questions#index'
  # post '/questions', to: 'questions#create'
  # get '/questions/:id/edit', to: 'questions#edit' - вмето :id будет автоматически подставлять id из базы,
  # где : означает что это переменная поля
  # чтобы создать множество маршрутов для одного контроллера, удобнее писать
  # resources :questions #, only: %i[index new edit create update destroy] # %i чтобы не писать [:index :new :edit :create]

  # Для использования questions и answers - вложенные маршруты
  resources :questions do
    resources :answers, only: %i[create destroy]
  end

  root 'pages#index'
end
