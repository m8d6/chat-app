Rails.application.routes.draw do
  resource :registration, only: %i[new create]

  # Sessions rotaları
  get  "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/login", to: "sessions#new", as: "new_session"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
