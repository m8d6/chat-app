Rails.application.routes.draw do
   resource :registration, only: [ :new, :create ]
   root "registrations#new"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/login", to: "sessions#new", as: "new_session"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
