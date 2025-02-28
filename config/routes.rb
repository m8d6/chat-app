Rails.application.routes.draw do
  get "/login", to: "sessions#new", as: "new_session"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"

  get "/password/reset", to: "passwords#new", as: "new_password"
  post "/password/reset", to: "passwords#create", as: "password_reset"
  get "/password/reset/:token", to: "passwords#edit", as: "edit_password"
  patch "/password/reset/:token", to: "passwords#update"

  root "dashboard#index" # Ana sayfa olarak dashboard'u kullanalım
  
  # Oturum gerektiren sayfalar için
  get "/dashboard", to: "dashboard#index"
end
