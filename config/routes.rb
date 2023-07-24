Rails.application.routes.draw do
  root "application#homepage"
  resources :comments
  resources :works
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  patch "/uploadAvatar/:id", to: "work#upload_avatar"
end
